//
//  ContentView.swift
//  SettingExample
//
//  Created by A. Zheng (github.com/aheze) on 2/22/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import Setting
import SwiftUI

class ViewModel: ObservableObject {
    @AppStorage("languageIndex") var languageIndex = 0
    @AppStorage("turboMode") var turboMode = true
    @AppStorage("brightness") var brightness = Double(50)
    @AppStorage("themeIndex") var themeIndex = 0
    @AppStorage("enableNotifications") var enableNotifications = true
    @AppStorage("notificationIndex") var notificationIndex = 0
    @AppStorage("notificationPromo") var notificationPromo = true
    @AppStorage("notificationUpdates") var notificationUpdates = true
    @AppStorage("color") var color = 0xFF3100
    @Published var showingAlert = false
}

struct ContentView: View {
    @StateObject var model = ViewModel()

    var body: some View {
        SettingStack {
            SettingPage(title: "Settings", spacing: 16, verticalPadding: 0, navigationTitleDisplayMode: .large) {
                SettingGroup {
                    SettingPage(
                        title: "General",
                        previewConfiguration: .init(
                            icon: .system(icon: "gear", backgroundColor: Color(hex: 0x006DC1))
                        )
                    ) {
                        SettingCustomView(id: "Header View") {
                            VStack(spacing: 8) {
                                Text("Welcome to Setting!")
                                    .font(.headline)

                                Text("Feel free to play around with this example app.")
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

                        SettingGroup(header: "Super customizable!") {
                            SettingToggle(title: "Turbo Mode", isOn: $model.turboMode)

                            if model.turboMode {
                                SettingText(title: "Turbo mode is on!", foregroundColor: Setting.secondaryLabelColor)
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
                                    title: "Frequency",
                                    choices: [
                                        "Every Hour",
                                        "Every Day",
                                        "Every Week"
                                    ],
                                    selectedIndex: $model.notificationIndex
                                )
                            }

                            SettingGroup(header: "You can't turn these off. HEHEHAHA!") {
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
                                if #available(iOS 16.0, macOS 12.0, *) {
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

                SettingGroup(header: "Brightness", footer: "Selected brightness: \(Int(model.brightness))") {
                    SettingSlider(value: $model.brightness, range: 0 ... 100, minimumImage: Image(systemName: "sun.min"), maximumImage: Image(systemName: "sun.max"))

                    SettingPicker(
                        title: "Mode",
                        choices: [
                            "Classic",
                            "Dark",
                            "Ultra Dark",
                            "Super Bright",
                        ],
                        selectedIndex: $model.themeIndex
                    )
                }

                SettingCustomView(id: "Custom Footer", titleForSearch: "This is a custom view!") {
                    Text("This is a custom view!")
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
                            .foregroundColor(Setting.secondaryLabelColor)
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

extension Color {
    init(hex: Int, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 08) & 0xFF) / 255,
            blue: Double((hex >> 00) & 0xFF) / 255,
            opacity: alpha
        )
    }

    var hex: UInt {
        return getHex() ?? 0x00AEEF
    }

    /// from https://stackoverflow.com/a/28645384/14351818
    func getHex() -> UInt? {
        var fRed: CGFloat = 0
        var fGreen: CGFloat = 0
        var fBlue: CGFloat = 0
        var fAlpha: CGFloat = 0

        #if os(iOS)

            let color = UIColor(self)

            if color.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
                fRed = fRed.clamped(to: 0 ... 1)
                fGreen = fGreen.clamped(to: 0 ... 1)
                fBlue = fBlue.clamped(to: 0 ... 1)

                let iRed = UInt(fRed * 255.0)
                let iGreen = UInt(fGreen * 255.0)
                let iBlue = UInt(fBlue * 255.0)

                //  (Bits 24-31 are alpha, 16-23 are red, 8-15 are green, 0-7 are blue).
                let hex = (iRed << 16) + (iGreen << 8) + iBlue
                return hex
            } else {
                // Could not extract RGBA components:
                return nil
            }
        #else
            let color = NSColor(self)

            color.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha)
            fRed = fRed.clamped(to: 0 ... 1)
            fGreen = fGreen.clamped(to: 0 ... 1)
            fBlue = fBlue.clamped(to: 0 ... 1)

            let iRed = UInt(fRed * 255.0)
            let iGreen = UInt(fGreen * 255.0)
            let iBlue = UInt(fBlue * 255.0)

            //  (Bits 24-31 are alpha, 16-23 are red, 8-15 are green, 0-7 are blue).
            let hex = (iRed << 16) + (iGreen << 8) + iBlue
            return hex

        #endif
    }
}

extension Comparable {
    /// used for the UIColor
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
