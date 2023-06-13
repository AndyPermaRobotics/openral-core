export class Definition {
    constructor(
        public definitionText: string | null = null,
        public definitionUrl: string | null = null
    ) { }

    toMap(): Record<string, any> {
        return {
            'definitionText': this.definitionText,
            'definitionUrl': this.definitionUrl,
        };
    }

    static fromMap(data: Record<string, any>): Definition {
        const definitionText = data['definitionText'] ?? null;
        const definitionUrl = data['definitionUrl'] ?? null;

        return new Definition(definitionText, definitionUrl);
    }
}
