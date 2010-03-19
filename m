From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Fri, 19 Mar 2010 11:18:27 +0000
Subject: git sh-2.6 boot built with coderurgery
Message-Id: <201003191218.27066.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Soem questions:
what is the meaning of 
... MOUNT_ROOT_RDONLY - 00000000
... RAMDISK_FLAGS     - 00000000
... ORIG_ROOT_DEV     - 00000000
... LOADER_TYPE       - 00000000
... INITRD_START      - 00000000
... INITRD_SIZE       - 00000000


I do not like to use u-boot; can woprk fullfeatured at all?

Thanks a lot


This is the output


Mavel s.r.l. MLCD is alive.
Memory test Done.

LCD Model: ET057003DH6 16 bpp
Framebuffer base address: 0x0E000000
Booting with 32 Bit SDRAM Interface
Bootload Complete
Bootloader compiled at : Mar 19 2010 : 11:57:53
Starting linux Decompressor
Linux version 2.6.33 (fgiovagnini@aurio01) (gcc version 4.4.1 (Sourcery G++ 
Lite 4.4-45) ) #13 Fri Mar 19 11:43:00 CET 2010
Boot params:
... MOUNT_ROOT_RDONLY - 00000000
... RAMDISK_FLAGS     - 00000000
... ORIG_ROOT_DEV     - 00000000
... LOADER_TYPE       - 00000000
... INITRD_START      - 00000000
... INITRD_SIZE       - 00000000
debug: ignoring loglevel setting.
Booting machvec: RSK+
Node 0: start_pfn = 0xc000, low = 0xd000
Zone PFN ranges:
  Normal   0x0000c000 -> 0x0000d000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x0000c000 -> 0x0000d000
On node 0 totalpages: 4096
free_area_init_node: node 0, pgdat 0c282e70, node_mem_map 0c2c4000
  Normal zone: 32 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 4064 pages, LIFO batch:0
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 4064
Kernel command line: console=ttySC0,19200 earlyprintk=serial ignore_loglevel
PID hash table entries: 64 (order: -4, 256 bytes)
Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
I-cache : n_ways=4 n_sets8 way_incr 48
I-cache : entry_mask=0x000007f0 alias_mask=0x00000000 n_aliases=0
D-cache : n_ways=4 n_sets8 way_incr 48
D-cache : entry_mask=0x000007f0 alias_mask=0x00000000 n_aliases=0
Memory: 13280k/16384k available (1887k kernel code, 682k data, 108k init)
virtual kernel memory layout:
    fixmap  : 0x5fff7000 - 0x5ffff000   (  32 kB)
    vmalloc : 0x40000000 - 0x5fff5000   ( 511 MB)
    lowmem  : 0x0c000000 - 0x0d000000   (  16 MB) (cached)
            : 0x20000000 - 0x40000000   ( 512 MB) (uncached)
      .init : 0x0c284000 - 0x0c29f000   ( 108 kB)
      .data : 0x0c1d8cb0 - 0x0c283580   ( 682 kB)
      .text : 0x0c001000 - 0x0c1d8cb0   (1887 kB)
Hierarchical RCU implementation.
NR_IRQS:256 nr_irqs:256
  alloc irq_desc for 64 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 65 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 66 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 67 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 68 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 69 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 70 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 71 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 80 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 81 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 82 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 83 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 84 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 85 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 86 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 87 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 108 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 109 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 112 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 113 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 116 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 117 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 120 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 121 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 124 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 125 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 128 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 129 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 132 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 133 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 136 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 137 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 140 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 141 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 142 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 143 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 144 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 145 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 146 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 147 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 148 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 149 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 150 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 151 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 152 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 153 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 154 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 155 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 156 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 157 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 158 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 159 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 160 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 161 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 162 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 163 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 164 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 165 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 166 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 167 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 168 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 169 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 170 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 171 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 172 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 173 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 174 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 175 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 176 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 177 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 178 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 179 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 180 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 181 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 182 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 183 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 184 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 185 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 186 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 187 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 188 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 189 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 190 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 191 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 192 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 193 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 194 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 195 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 196 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 197 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 198 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 199 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 200 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 201 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 202 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 203 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 204 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 205 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 206 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 207 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 208 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 209 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 210 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 211 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 212 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 213 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 214 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 215 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 216 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 217 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 224 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 225 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 226 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 227 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 231 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 232 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 233 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 234 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 235 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 236 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 237 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 238 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 239 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 240 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 241 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 242 on node 0
  alloc kstat_irqs on node 0
  alloc irq_desc for 243 on node 0
  alloc kstat_irqs on node 0
ODEBUG: 0 of 0 active objects replaced
sh_cmt: CMT0 used for clock events
sh_cmt: CMT0 used for periodic clock events
sh_mtu2: MTU2_0 used for clock events
Calibrating delay loop (skipped)... 200.04 BogoMIPS PRESET (lpj0024)
Mount-cache hash table entries: 512
CPU: SH7203
khelper used greatest stack depth: 7376 bytes left
regulator: core version 0.5
khelper used greatest stack depth: 7220 bytes left
NET: Registered protocol family 16
khelper used greatest stack depth: 7068 bytes left
sh pinmux: sh7203_pfc handling gpio 0 -> 329
bio: create slab <bio-0> at 0
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Switching to clocksource jiffies
khelper used greatest stack depth: 7064 bytes left
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 512 (order: 0, 4096 bytes)
TCP bind hash table entries: 512 (order: -1, 2048 bytes)
TCP: Hash tables configured (established 512 bind 512)
TCP reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
cpufreq: SuperH CPU frequency driver.
cpufreq: clock framework rate rounding not supported on CPU#0.
cmdlinepart partition parsing not available
msgmni has been set to 25
io scheduler noop registered (default)
SuperH SCI(F) driver initialized
sh-sci.0: ttySC0 at MMIO 0xfffe8000 (irq = 192) is a scif
console [ttySC0] enabled
sh-sci.1: ttySC1 at MMIO 0xfffe8800 (irq = 196) is a scif
sh-sci.2: ttySC2 at MMIO 0xfffe9000 (irq = 200) is a scif
sh-sci.3: ttySC3 at MMIO 0xfffe9800 (irq = 204) is a scif
physmap platform flash device: 00400001 at 20000000
physmap-flash: Found 1 x16 devices at 0x0 in 16-bit bank
NOR chip too large to fit in mapping. Attempting to cope...
 Amd/Fujitsu Extended Query Table at 0x0000
gen_probe: No supported Vendor Command Set found
khelper used greatest stack depth: 6980 bytes left
physmap-flash physmap-flash: map_probe failed
smsc911x: Driver version 2008-10-21.
r8a66597_hcd: driver r8a66597_hcd, 2009-05-26
sh_cmt: CMT0 kept as earlytimer
sh_cmt: CMT1 used for clock events
sh_mtu2: MTU2_0 kept as earlytimer
sh_mtu2: MTU2_1 used for clock events
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
TCP cubic registered
List of all partitions:
No filesystem could mount root, tried: 
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)
Stack: (0x0c811ed8 to 0x0c812000)
1ec0:                                                       0c1d61b6 0c811ee8 
1ee0: 0c1d62a0 0c0ee740 0c1d6212 0c811ef0 0c811f0c 0c284d90 0c811f18 0c2976c0 
1f00: 0c1d62a0 0c87b000 0c811f1c 0c811f1c 0c811f1c 0c811f0c 0c0eadb0 756e6b6e 
1f20: 6f776e2d 626c6f63 6b28312c 30290080 0c811f44 0c87b000 0c87b000 0c284eb2 
1f40: 0c811f5c 00000000 00000000 00000000 0c29f28c 00000100 00100000 0c28502c 
1f60: 0c811f70 0c002040 0c29c130 0c29f28c 0c2842ba 0c811f88 00000000 0c002040 
1f80: 0c29c130 0c070ef0 0c003af8 0c811f9c 00000000 00000000 00000000 00000000 
1fa0: 00000000 00000000 00000000 00000000 00000000 00000000 0c2841d4 00000000 
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
1fe0: 0c811f9c 0c003af0 00000000 40008000 00000000 00000000 00000000 00000000 

Call trace:
 [<0c1d61b6>] dump_stack+0xe/0x28
 [<0c1d62a0>] printk+0x0/0x30
 [<0c0ee740>] bust_spinlocks+0x0/0x50
 [<0c1d6212>] panic+0x42/0xd0
 [<0c284d90>] mount_block_root+0x194/0x20c
 [<0c1d62a0>] printk+0x0/0x30
 [<0c0eadb0>] strchr+0x0/0x40
 [<0c284eb2>] mount_root+0xaa/0x118
 [<0c28502c>] prepare_namespace+0x10c/0x1a0
 [<0c002040>] do_one_initcall+0x0/0x1d0
 [<0c2842ba>] kernel_init+0xe6/0x164
 [<0c002040>] do_one_initcall+0x0/0x1d0
 [<0c070ef0>] sys_dup+0x0/0x80
 [<0c003af8>] kernel_thread_helper+0x8/0x20
 [<0c2841d4>] kernel_init+0x0/0x164
 [<0c003af0>] kernel_thread_helper+0x0/0x20


-- 
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
