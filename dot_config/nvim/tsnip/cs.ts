import { Snippet } from "https://deno.land/x/tsnip_vim@v0.4/mod.ts";

const efprop: Snippet = {
  name: "efprop",
  text: "builder.Property(${1:entity} => ${1:entity}.${2:Property})",
  params: [
    {
      name: "entity",
      type: "single_line",
    },
    {
      name: "property",
      type: "single_line",
    },
  ],
  render: ({ entity, property }) =>
    `builder.Property(${entity?.text ?? ""} => ${entity?.text ?? ""}.${
      property?.text ?? ""
    });`,
};

const COLLECTION_TYPES = [
  "IEnumerable",
  "List",
  "IReadOnlyList",
  "ICollection",
];

const suggestionPropertyName = (typeName: string): string => {
  return (
    typeName.match(
      `(?:${COLLECTION_TYPES.join("|")})` +
        /<(?<containeredTypeName>\w\+)>[?]?/,
    )?.groups?.containeredTypeName ?? typeName
  );
};

export const prop: Snippet = {
  name: "prop",
  text: "Text",
  params: [
    {
      name: "modifier",
      type: "single_line",
    },
    {
      name: "type",
      type: "single_line",
    },
    {
      name: "name",
      type: "single_line",
    },
    {
      name: "property",
      type: "single_line",
    },
  ],
  render: ({ modifier, type, name, property }) => {
    return `${modifier?.text ?? "public"} ${type?.text ?? ""} ${
      name?.text ?? suggestionPropertyName(type?.text ?? "")
    } ${property?.text ?? "{ get; set; }"}`;
  },
};

export default {
  efprop,
  prop,
};
