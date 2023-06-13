import { Container } from "./container";

export class CurrentGeoLocation {
    constructor(
        public container: Container | null = null
    ) { }

    toMap(): Record<string, any> {
        return {
            'container': this.container?.toMap() ?? null,
        };
    }

    static fromMap(data: Record<string, any>): CurrentGeoLocation {
        if(data == null) {
            return new CurrentGeoLocation();
        }
        
        const containerData = data['container'];
        const container = containerData ? Container.fromMap(containerData) : null;
        return new CurrentGeoLocation(container);
    }
}
