# Neovim-configuration
---
# Neovim配置
## 基础配置
## 详细配置解释
- basic.lua： 基础配置，是对默认配置的一个重置。
- colorscheme.lua： 我们安装的主题皮肤配置，在这里切换主题。
- keybindings.lua： 快捷键的设置，所有插件的快捷键也都会放在这里。
- plugins.lua： 插件安装管理，插件安装或卸载全在这里设置。
- lsp 文件夹： 是对 Neovim 内置 LSP 功能的配置，包括常见编程语言与语法提示等。
- plugin-config 文件夹： 是对第三方插件的配置，未来每添加一个插件，这里就多一个配置文件。

## 快捷键详细配置说明

### 终极设置
空格键：normal模式输入: *leader键*  
Alt+j：三种模式下关闭当前模式  
hp：查看帮助文档  

### 保存文件
ww

### 分屏设置
- sv（Split Vertically）：垂直分屏
- sd（Split Horizontally）：水平分屏，为了避免与调整窗口大小冲突，改为sb
- sc（Close）：关闭当前窗口
- so（Others）：关闭其他窗口
- Shift+w/a/s/d：上下左右窗口跳转

### 调整各个窗口大小
- Ctrl+方向键：调整当前窗口大小
- sj：向下调整
- sk：向上调整
- sh：向左调整
- sl：向右调整
- s=：等比例

### Terminal模式
空格+t：在下方打开Terminal  
空格+vt：在右侧方打开Terminal  

### Visule模式
j：下移文本  
k：上移文本  
<：左缩进文本,当然在normal模式下易可  
\>：右缩进文本,当然在normal模式下易可  
Shift+j：选中文本向下移动  
Shift+k：选中文本向上移动  

### 浏览查看
Ctrl+j/k：向下或向上移动四行  
Ctrl+d/u（down or up）：向下或向上移动九行  

### 格式化
Ctrl+i  
zz：折叠代码块  
z：打开折叠代码块  

### 插件配置
#### nvim-tree
Shift+t：打开关闭nvim-tree  
v：打开文件垂直分屏  
h：打开文件水平分屏  
.：查看隐藏文件  
<F5>：刷新  
a（add）：创建文件  
d（delete）：删除文件  
r（rename）：改名文件  
x（cut）：剪切文件  
c（copy）：复制文件  
p（paste）：粘贴文件,若没有可粘贴的文件，使用该快捷键将跳转到父节点  
Shift+k：跳转到当前目录下同级的第一个结点  
Shift+j：跳转到当前目录下同级的最后一个结点  
Ctrl+k：查看文件信息：文件大小、访问创建修改时间、文件路径  

#### bufferline
Ctrl+c：关闭当前Tab  
Ctrl+h：向左切换Tab  
Ctrl+l：享有切换Tab  

#### telescope
Alt+j/k：上下移动选项  
上下键：上下移动选项  
Ctrl+c：关闭窗口  

##### 查找文件
Ctrl+u/d：上下滚动预览窗口

#### nvim-cmp
Alt+.：出现补全  
Alt+j：取消补全  
Ctrl+j/k：上下移动选项  
Enter：确认  

#### comment

##### normal模式下
gii：行注释  
gnn：块注释  

##### visual模式下
ii：行注释  
mm：块注释  

####
## 命令
### 插件安装
:PackerSync 下载、加载、清除、安装插件

