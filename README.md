# gfw - GFW List to IPset Converter

## 简介 (Introduction)

本项目是一个工具或脚本，旨在将常用的 GFW List（一个包含被认为受防火长城干扰或屏蔽的域名列表）转换为 Linux 系统下 `ipset` 工具可以使用的 IP 地址集合。通过将这些 IP 地址放入一个 `ipset` 集合中，用户可以方便地配置防火墙规则（如 `iptables` 或 `nftables`），将访问这些目标 IP 的流量引导至代理服务器（如 Shadowsocks, V2Ray, Trojan 等），从而实现更高效、自动化的流量分流，达到科学上网的目的。

## 目的 (Purpose)

*   **自动化**：自动处理 GFW List，无需手动维护大量 IP 地址。
*   **高效性**：利用 `ipset` 的高效查找特性，减少防火墙规则的复杂度和匹配开销。
*   **易用性**：生成可以直接被 `ipset` 使用的命令或配置文件，简化配置流程。
*   **分流**：配合路由或防火墙策略，实现国内外流量的智能分流，仅让特定流量通过代理。

## 工作原理 (How it Works - 推测)

1.  **获取 GFW List**: 脚本首先会从指定的源（可能是项目内置的，或者需要用户提供，或者从网络如 GitHub 上的 gfwlist 项目获取）下载或读取 GFW List 文件。这个列表通常包含大量域名。
2.  **域名解析**: 遍历列表中的域名，使用系统的 DNS 解析器或指定的 DNS 服务器将这些域名解析为 IP 地址（可能包括 IPv4 和 IPv6）。
3.  **生成 IPset 命令**: 将解析得到的 IP 地址整理，并生成一系列 `ipset` 命令。这些命令通常包括：
    *   创建（如果不存在）一个指定名称的 `ipset` 集合（类型通常是 `hash:net` 或 `hash:ip`）。
    *   将所有解析到的 IP 地址添加到这个集合中。
4.  **输出**: 将生成的 `ipset` 命令输出到标准输出或保存到一个脚本文件中，供用户执行。

## 使用场景 (Use Cases)

*   在 Linux 路由器（如 OpenWrt, LEDE）上配置透明代理和自动分流。
*   在个人 Linux 电脑上配合代理客户端实现全局或部分应用的流量代理。
*   任何需要基于 GFW List 进行 IP 地址集合管理的场景。

## 如何使用 (How to Use - 示例，具体需看项目代码)

通常，这类项目会提供一个可执行脚本。使用方式可能如下：

```bash
# 假设脚本名为 gfw_to_ipset.sh，要创建的 ipset 名为 gfwlist
./gfw_to_ipset.sh gfwlist > create_gfw_ipset.sh

# 然后使用 root 权限执行生成的脚本
sudo bash ./create_gfw_ipset.sh

# 最后配置 iptables/nftables 规则，将匹配 gfwlist 集合的流量转发到代理端口
# (iptables 示例)
# sudo iptables -t nat -A PREROUTING -p tcp -m set --match-set gfwlist dst -j REDIRECT --to-port <your_proxy_port>
# sudo iptables -t nat -A OUTPUT -p tcp -m set --match-set gfwlist dst -j REDIRECT --to-port <your_proxy_port>
