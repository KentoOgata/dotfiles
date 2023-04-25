local augend = require 'dial.augend'
require('dial.config').augends:register_group {
  default = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    -- date (2022/02/19, etc.)
    augend.date.alias['%Y/%m/%d'],
    augend.date.alias['%m/%d/%Y'],
    augend.date.alias['%d/%m/%Y'],
    augend.date.alias['%m/%d/%y'],
    augend.date.alias['%d/%m/%y'],
    augend.date.alias['%m/%d'],
    augend.date.alias['%-m/%-d'],
    augend.date.alias['%Y-%m-%d'],
    augend.date.alias['%Y年%-m月%-d日'],
    augend.date.alias['%Y年%-m月%-d日(%ja)'],
    augend.date.alias['%H:%M:%S'],
    augend.date.alias['%H:%M'],
    augend.case.new {
      types = { 'camelCase', 'snake_case' },
      cyclic = true,
    },
  },
}
