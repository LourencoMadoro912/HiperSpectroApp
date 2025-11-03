plugins {
    id("com.android.application")
    id("kotlin-android")
    // O plugin do Flutter deve vir após os plugins do Android e Kotlin.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.hiper_spectro"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    // ✅ Usa Java 17 — elimina os avisos de versão obsoleta
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        // Define o ID único do app (podes mudar para o teu domínio real)
        applicationId = "com.example.hiper_spectro"

        // Configurações padrão do Flutter
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // ⚠️ Ajusta depois para tua assinatura real de release
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
