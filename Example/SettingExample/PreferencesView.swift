//
//  PreferencesView.swift
//  SettingExample
//
//  Created by A. Zheng (github.com/aheze) on 2/22/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import Setting
import SwiftUI

class PreferencesViewModel: ObservableObject {
    @AppStorage("languageIndex") var languageIndex = 0
    @AppStorage("turboMode") var turboMode = true
    @AppStorage("brightness") var brightness = Double(50)
    @AppStorage("iconIndex") var iconIndex = 0
    @AppStorage("modeIndex") var modeIndex = 0
    @AppStorage("enableNotifications") var enableNotifications = true
    @AppStorage("notificationIndex") var notificationIndex = 0
    @AppStorage("notificationPromo") var notificationPromo = true
    @AppStorage("notificationUpdates") var notificationUpdates = true
    @AppStorage("color") var color = 0xFF3100
    @AppStorage("text") var text = ""
    @Published var showingAlert = false
}

struct PreferencesView: View {
    @StateObject var model = PreferencesViewModel()

    var body: some View {
        SettingStack(isSearchable: false) { // if you want to show the searchbar just change the condition to true
            SettingPage(title: "Preferences") {
                SettingGroup {
                    SettingPage(
                        title: "General",
                        previewConfiguration: .init(
                            icon: .system(icon: "gear", backgroundColor: Color(hex: 0x006DC1))
                        )
                    ) {
                        SettingCustomView(id: "Header View") {
                            VStack(spacing: 10) {
                                Image(systemName: "gearshape.fill")
                                    .font(.largeTitle)

                                Text("Welcome to Setting!")
                                    .font(.headline)
                            }
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(hex: 0x006DC1))
                            .frame(maxWidth: .infinity)
                            .padding(32)
                            .background(Color(hex: 0x006DC1).opacity(0.1))
                            .cornerRadius(12)
                            .padding(.horizontal, 16)
                        }

                        SettingGroup {
                            SettingButton(title: "View on GitHub") {
                                if let url = URL(string: "https://github.com/aheze/Setting") {
                                    #if os(iOS)
                                        UIApplication.shared.open(url)
                                    #else
                                        NSWorkspace.shared.open(url)
                                    #endif
                                }
                            }

                            SettingButton(title: "My Twitter") {
                                if let url = URL(string: "https://twitter.com/aheze0") {
                                    #if os(iOS)
                                        UIApplication.shared.open(url)
                                    #else
                                        NSWorkspace.shared.open(url)
                                    #endif
                                }
                            }
                        }

                        SettingGroup {
                            SettingPicker(
                                title: "Language",
                                choices: [
                                    "English",
                                    "Spanish",
                                    "French",
                                    "Italian",
                                    "Chinese",
                                    "Japanese",
                                    "Korean",
                                    "German",
                                ],
                                selectedIndex: $model.languageIndex
                            )
                        }

                        SettingGroup(header: "Brightness", footer: "Selected brightness: \(Int(model.brightness))") {
                            SettingSlider(value: $model.brightness, range: 0 ... 100, minimumImage: Image(systemName: "sun.min"), maximumImage: Image(systemName: "sun.max"))
                        }

                        SettingGroup(header: "Super customizable!") {
                            SettingToggle(title: "Turbo Mode", isOn: $model.turboMode)

                            if model.turboMode {
                                SettingText(title: "Turbo mode is on!", foregroundColor: SettingTheme.secondaryLabelColor)
                            }

                            SettingButton(title: "Show Alert") {
                                model.showingAlert = true
                            }
                        }
                    }
                }

                SettingGroup {
                    SettingPage(
                        title: "Privacy",
                        previewConfiguration: .init(
                            icon: .system(icon: "hand.raised.fill", backgroundColor: Color(hex: 0x00C130))
                        )
                    ) {
                        SettingGroup(header: "You can't turn these off. HEHEHAHA!") {
                            SettingToggle(title: "Track Location", isOn: .constant(true))
                            SettingToggle(title: "Track Data", isOn: .constant(true))
                            SettingToggle(title: "Track Browsing History", isOn: .constant(true))
                            SettingToggle(title: "Track Battery Usage", isOn: .constant(true))
                            SettingToggle(title: "Record Audio in Background", isOn: .constant(true))
                            SettingToggle(title: "Download Ads", isOn: .constant(true))
                            SettingToggle(title: "Show Ads", isOn: .constant(true))
                        }

                        SettingGroup {
                            SettingPage(title: "Advanced") {
                                SettingGroup(footer: "Tap to sell all your data to Google.") {
                                    SettingButton(title: "Sell Data to Google") {
                                        print("Data Sold!")
                                    }
                                }
                            }
                        }
                    }

                    SettingPage(
                        title: "Notifications",
                        previewConfiguration: .init(
                            icon: .system(icon: "bell.badge.fill", backgroundColor: Color(hex: 0xFF2300))
                        )
                    ) {
                        SettingGroup(footer: model.enableNotifications ? nil : "Turn on to see more settings.") {
                            SettingToggle(title: "Enable Notifications", isOn: $model.enableNotifications)
                        }

                        if model.enableNotifications {
                            SettingGroup {
                                SettingPicker(
                                    title: "Frequency (Navigation)",
                                    choices: [
                                        "Every Hour",
                                        "Every Day",
                                        "Every Week"
                                    ],
                                    selectedIndex: $model.notificationIndex
                                )
                                .pickerDisplayMode(.navigation)
                            }

                            SettingGroup {
                                SettingPicker(
                                    title: "Frequency (Menu)",
                                    choices: [
                                        "Every Hour",
                                        "Every Day",
                                        "Every Week"
                                    ],
                                    selectedIndex: $model.notificationIndex
                                )
                                .pickerDisplayMode(.menu)
                            }

                            SettingGroup(header: "Frequency (Inline)") {
                                SettingPicker(
                                    title: "Frequency (Inline)",
                                    choices: [
                                        "Every Hour",
                                        "Every Day",
                                        "Every Week"
                                    ],
                                    selectedIndex: $model.notificationIndex
                                )
                                .pickerDisplayMode(.inline)
                            }

                            SettingGroup {
                                SettingToggle(title: "Send Promotional Emails", isOn: $model.notificationPromo)
                                SettingToggle(title: "Send Product Updates", isOn: $model.notificationUpdates)
                            }
                        }
                    }

                    SettingPage(
                        title: "Themes",
                        previewConfiguration: .init(
                            icon: .system(icon: "paintbrush.fill", backgroundColor: Color(hex: model.color))
                        )
                    ) {
                        SettingCustomView(id: "Color Picker Preview") {
                            VStack {
                                if #available(iOS 16.0, macOS 13.0, *) {
                                    Rectangle()
                                        .fill(Color(hex: model.color).gradient)
                                } else {
                                    Rectangle()
                                        .fill(Color(hex: model.color))
                                }
                            }
                            .frame(height: 100)
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.25), radius: 12, x: 0, y: 6)
                            .padding(.horizontal, 16)
                        }

                        SettingGroup {
                            SettingText(title: "Choose a Color")

                            SettingCustomView(id: "Color Picker") {
                                let binding = Binding {
                                    Color(hex: model.color)
                                } set: { newValue in
                                    model.color = Int(newValue.hex)
                                }

                                ColorPicker("Color", selection: binding)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                            }
                        }
                    }
                }

                SettingGroup {
                    SettingPicker(
                        title: "App Icon",
                        choices: [
                            "Classic",
                            "Dark",
                            "Neon",
                        ],
                        selectedIndex: $model.iconIndex
                    )

                    SettingPicker(
                        title: "Mode",
                        choices: [
                            "Automatic",
                            "Light",
                            "Dark",
                        ],
                        selectedIndex: $model.modeIndex
                    )
                }

                SettingGroup {
                    SettingTextField(placeholder: "Enter text here", text: $model.text)
                }

                SettingCustomView(id: "Custom Footer", titleForSearch: "Welcome to Setting!") {
                    Text("Welcome to Setting!")
                        .foregroundColor(.white)
                        .font(.headline)
                        .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 1)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 20)
                        .background {
                            LinearGradient(
                                colors: [
                                    Color(hex: 0xFF00C7),
                                    Color(hex: 0xFFBF00),
                                ],
                                startPoint: .bottomLeading,
                                endPoint: .topTrailing
                            )
                            .brightness(model.brightness / 200 - 0.5)
                        }
                        .cornerRadius(12)
                        .padding(.horizontal, 16)
                }

                SettingCustomView(id: "Footer Link") {
                    Button {
                        if let url = URL(string: "https://twitter.com/aheze0") {
                            #if os(iOS)
                                UIApplication.shared.open(url)
                            #else
                                NSWorkspace.shared.open(url)
                            #endif
                        }
                    } label: {
                        Image("Twitter")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(SettingTheme.secondaryLabelColor)
                            .frame(width: 30, height: 30)
                            .padding(6)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .alert("Here's an alert!", isPresented: $model.showingAlert) {
            Button("OK") {}
        }
    }
}
