import { LynxContext, LynxModule } from '@lynx/lynx';
import common from '@ohos.app.ability.common';
import { preferences } from '@kit.ArkData';

export class NativeLocalStorageModule extends LynxModule {
  private static readonly PREF_NAME: string = "NativeLocalStorageModule";
  private dataPreferences: preferences.Preferences | null = null;

  constructor(context: LynxContext, param?: Object) {
    super(context, param);
    this.initPreferencesSync();
  }

  private initPreferencesSync() {
    try {
      this.dataPreferences = preferences.getPreferencesSync(
        getContext(),
        { name: NativeLocalStorageModule.PREF_NAME }
      );
      console.info("Preferences initialization succeeded.");
    } catch (error) {
      console.error(`Failed to initialize preferences: ${error}`);
    }
  }

  public setStorageItem(key: string, value: string) {
    if (!this.dataPreferences) {
      console.error("Preferences instance is not initialized.");
      return;
    }

    try {
      this.dataPreferences.putSync(key, value);
      this.dataPreferences.flushSync();
      console.info(`Storage item set successfully. key=${key}`);
    } catch (err) {
      console.error(`Failed to set storage item. key=${key}, error=${err.message}`);
    }
  }

  public getStorageItem(key: string, callback: (value: string)=> void) {
    if (!this.dataPreferences) {
      console.error("Preferences instance is not initialized.");
      callback("");
      return;
    }

    try {
      const value = this.dataPreferences.getSync(key, "");
      callback(value as string);
      return;
    } catch (err) {
      console.error(`Failed to get storage item. key=${key}, error=${err.message}`);
      callback("");
      return;
    }
  }

  public clearStorage() {
    if (!this.dataPreferences) {
      console.error("Preferences instance is not initialized.");
      return;
    }

    try {
      this.dataPreferences.clearSync();
      this.dataPreferences.flushSync();
      console.info("Storage cleared successfully.");
    } catch (err) {
      console.error(`Failed to clear storage. error=${err.message}`);
    }
  }
}
