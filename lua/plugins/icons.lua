return {
  {
    'nvim-tree/nvim-web-devicons',
    opts = {
      override_by_extension = {
        ['gleam'] = {
          icon = '',
          color = '#ffaff3',
          name = 'Gleam',
        },
        ['odin'] = {
          icon = '󰠠 ',
          color = '#3982d2',
          name = 'Odin',
        },
        ['pkg'] = {
          icon = '󰏖',
          color = '#ffdd63',
          name = 'Octo',
        },
        ['adoc'] = {
          icon = '󰬈',
          color = '#e40046',
          name = 'AsciiDoc',
        },
      },
    },
  },
}
