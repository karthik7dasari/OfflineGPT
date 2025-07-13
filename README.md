# OfflineGPT

A lightweight iOS app that allows offline interaction with Apple’s on-device large language models using the Foundation Models framework.

---

## 🚀 Features

- Run Apple’s on-device LLMs with zero network dependency
- SwiftUI-based modern UI
- Powered by the new Foundation Models framework (iOS 18+)
- No API keys or server-side components required

---

## 🛠 Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/karthik7dasari/OfflineGPT.git
   ```
2. Open `OfflineGPT.xcodeproj` (or `.xcworkspace` if using CocoaPods)
3. Build and run in Xcode (ensure a valid iOS 26+ device is selected)

---

## 📦 Requirements

- Xcode 26+
- iOS 26.0+
- Swift 6.2+
- Apple Silicon (for model support)

---

## 🧠 How It Works

- Uses Apple’s **Foundation Models** framework introduced in iOS 26
- Leverages on-device LLMs through `LanguageModel`, `LanguageModelSession`
- Token streaming handled using Combine for real-time UI updates
- No external API calls — 100% offline and privacy-first

---

## 📂 Folder Structure

```
OfflineGPT/
├── OfflineGPTApp.swift
├── ViewModels/
├── Views/
├── Models/
├── Resources/
├── Utilities/
└── README.md
```

---

## ✍️ Author

- **Karthik Dasari**
- [LinkedIn](https://www.linkedin.com/in/dkarthik512/)

---

## 📄 License

This project is licensed under the MIT License – see the [LICENSE](LICENSE) file for details.


---

## ⚠️ Limitations

- Apple's on-device LLMs via Foundation Models are currently in **Beta** (as of iOS 26 Beta), and may return error responses for certain prompts.
- The Foundation Models framework **only works on real devices** — it is not supported on iOS simulators.
