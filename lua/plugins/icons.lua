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
          icon = '⭘',
          color = '#3982d2',
          name = 'Odin',
        },
      },
    },
  },
}
