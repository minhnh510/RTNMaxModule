import type { TurboModule } from "react-native/Libraries/TurboModule/RCTExport";
import { TurboModuleRegistry } from "react-native";

export interface Spec extends TurboModule {
  callApi(): Promise<string>;
  callApiAsync(params: string, callback: (data: string) => void): string;
}

export default (TurboModuleRegistry.get<Spec>("RTNMaxModule") as Spec) || null;
