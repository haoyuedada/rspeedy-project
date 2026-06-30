import {
  LynxTemplateResourceFetcher,
  LynxMediaResourceFetcher,
  LynxGenericResourceFetcher,
  LynxView,
  ThreadStrategyForRendering,
} from '@lynx/lynx';
import { hiTraceMeter } from '@kit.PerformanceAnalysisKit';

import { ExampleTemplateResourceFetcher } from '../provider/ExampleTemplateResourceFetcher';
import { ExampleMediaResourceFetcher } from '../provider/ExampleMediaResourceFetcher';
import { ExampleGenericResourceFetcher } from  '../provider/ExampleGenericResourceFetcher';

@Entry
@Component
struct Index {
  templateResourceFetcher: LynxTemplateResourceFetcher = new ExampleTemplateResourceFetcher();
  mediaResourceFetcher: LynxMediaResourceFetcher = new ExampleMediaResourceFetcher();
  genericResourceFetcher: LynxGenericResourceFetcher = new ExampleGenericResourceFetcher();
  private url: string = 'main.lynx.bundle';

  aboutToAppear(): void {
    console.log("chy aboutToAppear")
    hiTraceMeter.startTrace('Index.aboutToAppear', 0);
    // TODO: add your initialization logic here
    hiTraceMeter.finishTrace('Index.aboutToAppear', 0);
  }

  build() {
    Column() {
      LynxView({
        templateResourceFetcher: this.templateResourceFetcher,
        mediaResourceFetcher: this.mediaResourceFetcher,
        genericResourceFetcher: this.genericResourceFetcher,
        url: this.url,
        threadMode: ThreadStrategyForRendering.MOST_ON_TASM,
      }).width('100%').height('50%');
      LynxView({
        templateResourceFetcher: this.templateResourceFetcher,
        mediaResourceFetcher: this.mediaResourceFetcher,
        genericResourceFetcher: this.genericResourceFetcher,
        url: this.url,
        threadMode: ThreadStrategyForRendering.MOST_ON_TASM,
      }).width('100%').height('50%');
    }
    .size({ width: '100%', height: '100%' })
  }
}