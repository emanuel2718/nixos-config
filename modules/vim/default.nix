{ pkgs, ... }:
{
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-airline fzf-vim ];
    settings = {
      number = true;
      expandtab = true;
      smartcase = true;
      tabstop = 2;
      shiftwidth = 2;
      mouse = "a";
    };
    extraConfig = ''
      filetype plugin indent on
      syntax enable

      set ruler
      set softtabstop=2

      " Splits
      set splitbelow
      set splitright
      nnoremap <C-J> <C-W><C-J>
      nnoremap <C-K> <C-W><C-K>
      nnoremap <C-L> <C-W><C-L>
      nnoremap <C-H> <C-W><C-H>

      let mapleader = " "

      nnoremap <leader>fs :w<cr>
      nnoremap <leader>q :qa!<cr>

      " Replace all occurences of word in file
      nnoremap <leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>
      
      " Last buffer switcher
      nnoremap <silent> <Leader>` :b#<cr>

      " Search files
      nnoremap <silent> <Leader>. :Files<cr>


      let g:fzf_layout = { 'down':  '40%'}
    '';
  };
}
