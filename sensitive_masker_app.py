import json
import re
import tkinter as tk
from pathlib import Path
from tkinter import filedialog, messagebox, simpledialog


APP_ROOT = Path(__file__).resolve().parent
SENSITIVE_WORDS_PATH = APP_ROOT / "sensitive_words.json"
RECENT_FILES_PATH = APP_ROOT / "recent_files.json"
OUTPUT_DIR = APP_ROOT / "output"


def load_json(path: Path, default):
    if not path.exists():
        return default
    try:
        with path.open("r", encoding="utf-8") as f:
            data = json.load(f)
        return data
    except (json.JSONDecodeError, OSError):
        return default


def save_json(path: Path, data):
    with path.open("w", encoding="utf-8") as f:
        json.dump(data, f, indent=2, ensure_ascii=False)


def read_text_file(path: Path) -> str:
    for encoding in ("utf-8", "utf-8-sig", "latin-1"):
        try:
            return path.read_text(encoding=encoding)
        except UnicodeDecodeError:
            continue
    return path.read_text(encoding="utf-8", errors="replace")


class SensitiveMaskerApp:
    def __init__(self, root: tk.Tk):
        self.root = root
        self.root.title("Sensitive Word Masker")
        self.root.geometry("1400x840")

        self.sensitive_words = load_json(
            SENSITIVE_WORDS_PATH,
            {"details": [], "products": [], "names": []},
        )
        self.recent_files = load_json(RECENT_FILES_PATH, [])
        self.selected_files = []
        self.is_dark = False
        self.last_preview_matches = []

        self._build_ui()
        self._refresh_categories()
        self._refresh_recent_files()
        self._apply_theme()

    def _build_ui(self):
        top = tk.Frame(self.root)
        top.pack(fill="x", padx=8, pady=8)

        tk.Button(top, text="Add File(s)", command=self.add_files).pack(side="left", padx=4)
        tk.Button(top, text="Remove Selected File", command=self.remove_selected_file).pack(side="left", padx=4)
        tk.Button(top, text="Clear File List", command=self.clear_file_list).pack(side="left", padx=4)
        tk.Button(top, text="Process Selected", command=self.process_selected_files).pack(side="left", padx=4)
        tk.Button(top, text="Process All", command=self.process_all_files).pack(side="left", padx=4)
        tk.Button(top, text="Toggle Dark/Light", command=self.toggle_theme).pack(side="right", padx=4)

        body = tk.PanedWindow(self.root, orient="horizontal", sashrelief="raised")
        body.pack(fill="both", expand=True, padx=8, pady=(0, 8))

        left = tk.Frame(body, width=320)
        body.add(left, minsize=300)

        right = tk.Frame(body)
        body.add(right)

        tk.Label(left, text="Selected Files").pack(anchor="w")
        self.file_list = tk.Listbox(left, height=16, exportselection=False)
        self.file_list.pack(fill="x", pady=(2, 8))
        self.file_list.bind("<<ListboxSelect>>", self.on_file_selected)

        tk.Label(left, text="Recent Files").pack(anchor="w")
        self.recent_list = tk.Listbox(left, height=12, exportselection=False)
        self.recent_list.pack(fill="x", pady=(2, 6))
        self.recent_list.bind("<Double-Button-1>", self.add_recent_file_to_selection)

        tk.Button(left, text="Add Selected Recent File", command=self.add_recent_file_to_selection).pack(fill="x")

        self.report_label = tk.Label(
            left,
            text="Mask Report: 0 words masked across 0 categories",
            justify="left",
            wraplength=280,
            anchor="w",
        )
        self.report_label.pack(fill="x", pady=(10, 0))

        notebook = tk.Frame(right)
        notebook.pack(fill="both", expand=True)

        preview_frame = tk.LabelFrame(notebook, text="Preview (Before / After)")
        preview_frame.pack(fill="both", expand=True, padx=4, pady=4)
        preview_frame.grid_columnconfigure(0, weight=1)
        preview_frame.grid_columnconfigure(1, weight=1)
        preview_frame.grid_rowconfigure(1, weight=1)

        tk.Label(preview_frame, text="Before").grid(row=0, column=0, sticky="w", padx=4, pady=2)
        tk.Label(preview_frame, text="After (Masked)").grid(row=0, column=1, sticky="w", padx=4, pady=2)

        self.before_text = tk.Text(preview_frame, wrap="none")
        self.before_text.grid(row=1, column=0, sticky="nsew", padx=4, pady=4)

        self.after_text = tk.Text(preview_frame, wrap="none")
        self.after_text.grid(row=1, column=1, sticky="nsew", padx=4, pady=4)

        manager_frame = tk.LabelFrame(notebook, text="Sensitive Words Manager")
        manager_frame.pack(fill="x", padx=4, pady=4)

        manager_frame.grid_columnconfigure(0, weight=1)
        manager_frame.grid_columnconfigure(1, weight=1)

        tk.Label(manager_frame, text="Categories").grid(row=0, column=0, sticky="w", padx=4, pady=2)
        tk.Label(manager_frame, text="Words in Category").grid(row=0, column=1, sticky="w", padx=4, pady=2)

        self.category_list = tk.Listbox(manager_frame, height=10, exportselection=False)
        self.category_list.grid(row=1, column=0, sticky="nsew", padx=4, pady=4)
        self.category_list.bind("<<ListboxSelect>>", self.on_category_selected)

        self.word_list = tk.Listbox(manager_frame, height=10, exportselection=False)
        self.word_list.grid(row=1, column=1, sticky="nsew", padx=4, pady=4)

        cat_btns = tk.Frame(manager_frame)
        cat_btns.grid(row=2, column=0, sticky="ew", padx=4, pady=2)
        tk.Button(cat_btns, text="Add Category", command=self.add_category).pack(side="left", padx=2)
        tk.Button(cat_btns, text="Rename Category", command=self.rename_category).pack(side="left", padx=2)
        tk.Button(cat_btns, text="Delete Category", command=self.delete_category).pack(side="left", padx=2)

        word_btns = tk.Frame(manager_frame)
        word_btns.grid(row=2, column=1, sticky="ew", padx=4, pady=2)
        tk.Button(word_btns, text="Add Word", command=self.add_word).pack(side="left", padx=2)
        tk.Button(word_btns, text="Edit Word", command=self.edit_word).pack(side="left", padx=2)
        tk.Button(word_btns, text="Delete Word", command=self.delete_word).pack(side="left", padx=2)

    def _apply_theme(self):
        if self.is_dark:
            bg = "#1e1e1e"
            fg = "#f0f0f0"
            panel_bg = "#2a2a2a"
            select_bg = "#3a6ea5"
            highlight_bg = "#5d3a00"
            masked_bg = "#7b1f1f"
        else:
            bg = "#f0f0f0"
            fg = "#111111"
            panel_bg = "#ffffff"
            select_bg = "#b5d5ff"
            highlight_bg = "#fff2a8"
            masked_bg = "#ffc5c5"

        self.root.configure(bg=bg)

        for widget in self.root.winfo_children():
            self._apply_widget_theme(widget, bg, fg, panel_bg, select_bg)

        self.before_text.tag_config("masked_before", background=highlight_bg)
        self.after_text.tag_config("masked_after", background=masked_bg)

    def _apply_widget_theme(self, widget, bg, fg, panel_bg, select_bg):
        cls = widget.winfo_class()
        try:
            if cls in {"Frame", "Labelframe", "Panedwindow"}:
                widget.configure(bg=bg, fg=fg)
            elif cls == "Label":
                widget.configure(bg=bg, fg=fg)
            elif cls == "Button":
                widget.configure(bg=panel_bg, fg=fg, activebackground=select_bg)
            elif cls in {"Listbox", "Text"}:
                widget.configure(
                    bg=panel_bg,
                    fg=fg,
                    insertbackground=fg,
                    selectbackground=select_bg,
                )
        except tk.TclError:
            pass

        for child in widget.winfo_children():
            self._apply_widget_theme(child, bg, fg, panel_bg, select_bg)

    def toggle_theme(self):
        self.is_dark = not self.is_dark
        self._apply_theme()
        self.refresh_preview()

    def _save_sensitive_words(self):
        save_json(SENSITIVE_WORDS_PATH, self.sensitive_words)

    def _save_recent_files(self):
        save_json(RECENT_FILES_PATH, self.recent_files[:15])

    def _refresh_categories(self):
        self.category_list.delete(0, tk.END)
        for category in sorted(self.sensitive_words.keys()):
            self.category_list.insert(tk.END, category)
        if self.category_list.size() > 0:
            self.category_list.selection_set(0)
            self.on_category_selected()

    def _refresh_words(self, category):
        self.word_list.delete(0, tk.END)
        for word in self.sensitive_words.get(category, []):
            self.word_list.insert(tk.END, word)

    def _refresh_recent_files(self):
        self.recent_list.delete(0, tk.END)
        for path in self.recent_files:
            if Path(path).exists():
                self.recent_list.insert(tk.END, path)

    def current_category(self):
        sel = self.category_list.curselection()
        if not sel:
            return None
        return self.category_list.get(sel[0])

    def on_category_selected(self, _event=None):
        category = self.current_category()
        if category:
            self._refresh_words(category)

    def add_category(self):
        name = simpledialog.askstring("Add Category", "Category name:")
        if not name:
            return
        name = name.strip()
        if not name:
            return
        if name in self.sensitive_words:
            messagebox.showerror("Duplicate", "Category already exists.")
            return
        self.sensitive_words[name] = []
        self._save_sensitive_words()
        self._refresh_categories()

    def rename_category(self):
        category = self.current_category()
        if not category:
            return
        new_name = simpledialog.askstring("Rename Category", "New category name:", initialvalue=category)
        if not new_name:
            return
        new_name = new_name.strip()
        if not new_name:
            return
        if new_name != category and new_name in self.sensitive_words:
            messagebox.showerror("Duplicate", "Category already exists.")
            return
        self.sensitive_words[new_name] = self.sensitive_words.pop(category)
        self._save_sensitive_words()
        self._refresh_categories()

    def delete_category(self):
        category = self.current_category()
        if not category:
            return
        ok = messagebox.askyesno("Delete Category", f"Delete '{category}' and all words inside it?")
        if not ok:
            return
        self.sensitive_words.pop(category, None)
        self._save_sensitive_words()
        self._refresh_categories()
        self.refresh_preview()

    def add_word(self):
        category = self.current_category()
        if not category:
            messagebox.showerror("No Category", "Create or select a category first.")
            return
        word = simpledialog.askstring("Add Word", f"New sensitive word for '{category}':")
        if not word:
            return
        word = word.strip()
        if not word:
            return
        if word in self.sensitive_words[category]:
            messagebox.showerror("Duplicate", "Word already exists in this category.")
            return
        self.sensitive_words[category].append(word)
        self._save_sensitive_words()
        self._refresh_words(category)
        self.refresh_preview()

    def edit_word(self):
        category = self.current_category()
        sel = self.word_list.curselection()
        if not category or not sel:
            return
        old_word = self.word_list.get(sel[0])
        new_word = simpledialog.askstring("Edit Word", "Update sensitive word:", initialvalue=old_word)
        if not new_word:
            return
        new_word = new_word.strip()
        if not new_word:
            return
        words = self.sensitive_words[category]
        if new_word != old_word and new_word in words:
            messagebox.showerror("Duplicate", "Word already exists in this category.")
            return
        words[sel[0]] = new_word
        self._save_sensitive_words()
        self._refresh_words(category)
        self.word_list.selection_set(sel[0])
        self.refresh_preview()

    def delete_word(self):
        category = self.current_category()
        sel = self.word_list.curselection()
        if not category or not sel:
            return
        word = self.word_list.get(sel[0])
        ok = messagebox.askyesno("Delete Word", f"Delete '{word}' from '{category}'?")
        if not ok:
            return
        del self.sensitive_words[category][sel[0]]
        self._save_sensitive_words()
        self._refresh_words(category)
        self.refresh_preview()

    def add_files(self):
        file_paths = filedialog.askopenfilenames(
            title="Select file(s) to mask",
            filetypes=[("All files", "*.*")],
        )
        if not file_paths:
            return
        for file_path in file_paths:
            p = str(Path(file_path))
            if p not in self.selected_files:
                self.selected_files.append(p)
        self.refresh_file_list()
        self.file_list.selection_clear(0, tk.END)
        self.file_list.selection_set(tk.END)
        self.on_file_selected()

    def add_recent_file_to_selection(self, _event=None):
        sel = self.recent_list.curselection()
        if not sel:
            return
        path = self.recent_list.get(sel[0])
        if path not in self.selected_files and Path(path).exists():
            self.selected_files.append(path)
            self.refresh_file_list()
        if path in self.selected_files:
            idx = self.selected_files.index(path)
            self.file_list.selection_clear(0, tk.END)
            self.file_list.selection_set(idx)
            self.on_file_selected()

    def remove_selected_file(self):
        sel = self.file_list.curselection()
        if not sel:
            return
        idx = sel[0]
        self.selected_files.pop(idx)
        self.refresh_file_list()
        self.before_text.delete("1.0", tk.END)
        self.after_text.delete("1.0", tk.END)
        self.report_label.config(text="Mask Report: 0 words masked across 0 categories")

    def clear_file_list(self):
        self.selected_files = []
        self.refresh_file_list()
        self.before_text.delete("1.0", tk.END)
        self.after_text.delete("1.0", tk.END)
        self.report_label.config(text="Mask Report: 0 words masked across 0 categories")

    def refresh_file_list(self):
        self.file_list.delete(0, tk.END)
        for path in self.selected_files:
            self.file_list.insert(tk.END, path)

    def on_file_selected(self, _event=None):
        sel = self.file_list.curselection()
        if not sel:
            return
        path = Path(self.file_list.get(sel[0]))
        if not path.exists():
            messagebox.showerror("File Missing", f"File not found:\n{path}")
            return
        self.update_preview_for_file(path)
        self._add_to_recent(path)

    def _build_matcher(self):
        patterns = []
        word_to_category = {}
        for category, words in self.sensitive_words.items():
            for word in words:
                if not word or not word.strip():
                    continue
                raw = word.strip()
                key = raw.casefold()
                word_to_category.setdefault(key, category)
                if re.fullmatch(r"\w+", raw):
                    p = rf"(?<!\w){re.escape(raw)}(?!\w)"
                else:
                    p = re.escape(raw)
                patterns.append((raw, p))

        if not patterns:
            return None, {}

        patterns.sort(key=lambda item: len(item[0]), reverse=True)
        combined_pattern = "|".join(p for _, p in patterns)
        return re.compile(combined_pattern, re.IGNORECASE), word_to_category

    def mask_text(self, text: str):
        matcher, word_to_category = self._build_matcher()
        if matcher is None:
            return text, [], 0, 0

        matches = []
        categories_hit = set()

        for m in matcher.finditer(text):
            matched_text = m.group(0)
            category = word_to_category.get(matched_text.casefold(), "uncategorized")
            categories_hit.add(category)
            matches.append(
                {
                    "start": m.start(),
                    "end": m.end(),
                    "category": category,
                    "text": matched_text,
                }
            )

        if not matches:
            return text, [], 0, 0

        out_parts = []
        pointer = 0
        for m in matches:
            out_parts.append(text[pointer : m["start"]])
            out_parts.append("*" * (m["end"] - m["start"]))
            pointer = m["end"]
        out_parts.append(text[pointer:])
        masked = "".join(out_parts)

        return masked, matches, len(matches), len(categories_hit)

    def refresh_preview(self):
        sel = self.file_list.curselection()
        if not sel:
            return
        path = Path(self.file_list.get(sel[0]))
        if path.exists():
            self.update_preview_for_file(path)

    def update_preview_for_file(self, file_path: Path):
        text = read_text_file(file_path)
        masked_text, matches, mask_count, category_count = self.mask_text(text)
        self.last_preview_matches = matches

        self.before_text.delete("1.0", tk.END)
        self.after_text.delete("1.0", tk.END)
        self.before_text.insert("1.0", text)
        self.after_text.insert("1.0", masked_text)

        self.before_text.tag_remove("masked_before", "1.0", tk.END)
        self.after_text.tag_remove("masked_after", "1.0", tk.END)

        for m in matches:
            start = f"1.0+{m['start']}c"
            end = f"1.0+{m['end']}c"
            self.before_text.tag_add("masked_before", start, end)
            self.after_text.tag_add("masked_after", start, end)

        self.report_label.config(
            text=f"Mask Report: {mask_count} words masked across {category_count} categories"
        )

    def _add_to_recent(self, file_path: Path):
        path_str = str(file_path)
        if path_str in self.recent_files:
            self.recent_files.remove(path_str)
        self.recent_files.insert(0, path_str)
        self.recent_files = self.recent_files[:15]
        self._save_recent_files()
        self._refresh_recent_files()

    def _process_files(self, files):
        if not files:
            messagebox.showwarning("No Files", "Please select at least one file.")
            return

        OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
        total_masks = 0
        categories_hit = set()
        written = []

        for file_path_str in files:
            file_path = Path(file_path_str)
            if not file_path.exists():
                continue
            original = read_text_file(file_path)
            masked_text, matches, mask_count, _ = self.mask_text(original)
            out_file = OUTPUT_DIR / file_path.name
            out_file.write_text(masked_text, encoding="utf-8")
            total_masks += mask_count
            for m in matches:
                categories_hit.add(m["category"])
            written.append(str(out_file))
            self._add_to_recent(file_path)

        messagebox.showinfo(
            "Processing Complete",
            f"Saved {len(written)} file(s) to:\n{OUTPUT_DIR}\n\n"
            f"{total_masks} words masked across {len(categories_hit)} categories.",
        )

        self.report_label.config(
            text=f"Mask Report: {total_masks} words masked across {len(categories_hit)} categories"
        )

    def process_selected_files(self):
        selections = self.file_list.curselection()
        files = [self.file_list.get(i) for i in selections]
        self._process_files(files)

    def process_all_files(self):
        self._process_files(self.selected_files)


def main():
    root = tk.Tk()
    app = SensitiveMaskerApp(root)
    root.mainloop()


if __name__ == "__main__":
    main()
