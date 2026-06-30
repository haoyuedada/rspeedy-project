import {
  LynxTemplateResourceFetcher,
  LynxMediaResourceFetcher,
  LynxGenericResourceFetcher,
  LynxView,
  ThreadStrategyForRendering,
  ModuleClassWrapper,
} from '@lynx/lynx';

import { ExampleTemplateResourceFetcher } from '../provider/ExampleTemplateResourceFetcher';
import { ExampleMediaResourceFetcher } from '../provider/ExampleMediaResourceFetcher';
import { ExampleGenericResourceFetcher } from  '../provider/ExampleGenericResourceFetcher';
import { NativeLocalStorageModule } from './NativeLocalStorageModule';

@Entry
@Component
struct Index {
  templateResourceFetcher: LynxTemplateResourceFetcher = new ExampleTemplateResourceFetcher();
  mediaResourceFetcher: LynxMediaResourceFetcher = new ExampleMediaResourceFetcher();
  genericResourceFetcher: LynxGenericResourceFetcher = new ExampleGenericResourceFetcher();
  modules: Map<string, ModuleClassWrapper> = new Map();
  private url: string = 'main.lynx.bundle';

  aboutToAppear(): void {
    this.modules.set('NativeLocalStorageModule', {
      moduleClass: NativeLocalStorageModule
    });
  }

  build() {
    Column() {
      LynxView({
        templateResourceFetcher: this.templateResourceFetcher,
        mediaResourceFetcher: this.mediaResourceFetcher,
        genericResourceFetcher: this.genericResourceFetcher,
        modules: this.modules,
        url: this.url,
        threadMode: ThreadStrategyForRendering.MOST_ON_TASM,
      }).width('100%').height('50%');
      // LynxView({
      //   templateResourceFetcher: this.templateResourceFetcher,
      //   mediaResourceFetcher: this.mediaResourceFetcher,
      //   genericResourceFetcher: this.genericResourceFetcher,
      //   modules: this.modules,
      //   url: this.url,
      //   threadMode: ThreadStrategyForRendering.MOST_ON_TASM,
      // }).width('100%').height('50%');
    }
    .size({ width: '100%', height: '100%' })
  }
}