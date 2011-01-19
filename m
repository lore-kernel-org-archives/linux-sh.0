From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Wed, 19 Jan 2011 08:42:00 +0000
Subject: Re: Booting kernel 2.6.37+ for renesas sh on sh2a 7203
Message-Id: <201101190942.01123.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201101161739.57933.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201101161739.57933.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Phil,
I found this document:
http://www.stlinux.com/u-boot/mkimage/kernel-images

and following its instructions I found:
$ sh-uclinux-objdump -f vmlinux | grep '^start address ' | awk '{print $3}'

and I got
0x0c800000

According to the document it should be the execute address ( I undestand it is 
the entry point).

If I execute the command:
$ sh-uclinux-objdump -f vmlinux | grep .empty_zero_page | awk '{print $4}'

Nothing happen, as this symbol is not into the header.

When I run make uImage the results are different as  wrote in precedent emails.
Could be this the problem?
How can I set the load address if no .empty_zero_page info I have?

Thanks a lot


On Tuesday 18 January 2011 18:40:51 Phil Edworthy wrote:
> Oh, one more thing... perhaps you can load the kernel straight into memory
> rather than flash. Then run from there. At least you would know if your
> kernel is running correctly or not.
> 
> Phil
> 
> > -----Original Message-----
> > From: Fabio Giovagnini [mailto:fabio.giovagnini@aurion-tech.com]
> > Sent: 18 January 2011 17:12
> > To: Phil Edworthy
> > Subject: Re: Booting kernel 2.6.37+ for renesas sh on sh2a 7203
> > 
> > This is my output:
> > Where could be the problem of nothing viewed on the terminal after the
> > decompression?
> > U-Boot 2010.12-09860-g9cb5761-dirty (Jan 18 2011 - 18:03:44)
> > 
> > CPU: SH2A
> > BOARD: MLCD7203
> > DRAM:  64MB
> > *** Warning - bad CRC, using default environment
> > 
> > Destroy Hash Table: 0c7d6e18 table = (null)
> > Create Hash Table: Nw
> > INSERT: table 0c7d6e18, filled 1/79 rv 0c780134 => name="bootargs"
> > value="console=ttySC0,115200 earlyprintk=serial ignore_loglevel"
> > INSERT: table 0c7d6e18, filled 2/79 rv 0c780080 => name="baudrate"
> > value="115200"
> > INSERT: table 0c7d6e18, filled 3/79 rv 0c780110 => name="loadaddr"
> > value="0x0C200000"
> > INSERT: free(data = 0c77ffb8)
> > INSERT: done
> > fwc addr 20000000 cmd f0 00f0 16bit x 16 bit
> > fwc addr 2000aaaa cmd aa 00aa 16bit x 16 bit
> > fwc addr 20005554 cmd 55 0055 16bit x 16 bit
> > fwc addr 2000aaaa cmd 90 0090 16bit x 16 bit
> > fwc addr 20000000 cmd f0 00f0 16bit x 16 bit
> > JEDEC PROBE: ID bf 236c 0
> > Found JEDEC Flash: SST 39VF6402B
> > unlock address index 1
> > unlock addresses are 0x555/0x2aa
> > erase_region_count = 128 erase_region_size = 65536
> > flash_protect ON: from 0x20000000 to 0x2001FFFF
> > protect on 0
> > protect on 1
> > flash_protect ON: from 0x20020000 to 0x2002FFFF
> > protect on 2
> > FLASH: 8MB
> > In:    serial
> > Out:   serial
> > Err:   serial
> > => loady
> > ## Ready for binary (ymodem) download to 0x0C200000 at 115200 bps...
> > C/0(CAN) packets, 3 retries
> > ## Total Size      = 0x000ee3a8 = 975784 Bytes
> > => iminfo
> > 
> > ## Checking Image at 0c200000 ...
> > 
> >    Legacy image found
> >    Image Name:   Linux-2.6.37+
> >    Image Type:   SuperH Linux Kernel Image (gzip compressed)
> >    Data Size:    975720 Bytes = 952.9 KiB
> >    Load Address: 0c001000
> >    Entry Point:  0c002000
> >    Verifying Checksum ... OK
> > 
> > => bootm
> > *  kernel: default image load address = 0x0c200000
> > ## Booting kernel from Legacy Image at 0c200000 ...
> > 
> >    Image Name:   Linux-2.6.37+
> >    Image Type:   SuperH Linux Kernel Image (gzip compressed)
> >    Data Size:    975720 Bytes = 952.9 KiB
> >    Load Address: 0c001000
> >    Entry Point:  0c002000
> >    Verifying Checksum ... OK
> >    kernel data at 0x0c200040, len = 0x000ee368 (975720)
> > 
> > ## No init Ramdisk
> > 
> >    ramdisk start = 0x00000000, ramdisk end = 0x00000000
> >    Uncompressing Kernel Image ... OK
> >    kernel loaded at 0x0c001000, end = 0x0c1af9fc
> >  
> >  CTRL-A Z for help |115200 8N1 | NOR | Minicom 2.4    | VT102 |
> > 
> > Offline
> > 
> > On Tuesday 18 January 2011 17:53:48 you wrote:
> > > => iminfo
> > > Unknown command 'iminfo' - try 'help'
> > > 
> > > 
> > > 
> > > Here's my output of uboot when booting:
> > > 
> > > U-Boot 2010.03 (Nov 29 2010 - 12:56:47)
> > > 
> > > CPU: SH4
> > > BOARD: ecovec
> > > DRAM:  256MB
> > > FLASH: 64MB
> > > In:    serial
> > > Out:   serial
> > > Err:   serial
> > > Net:   sh_eth
> > > => tftp;bootm
> > > 100Base/Full
> > > Using sh_eth device
> > > TFTP from server 192.168.10.30; our IP address is 192.168.10.31
> > > Filename '/rootfs/boot/uImage'.
> > > Load address: 0x89000000
> > > Loading: T
> > > #################################################################
> > > #################################################################
> > > #################################################################
> > > #################################################################
> > > #################################################################
> > > #################################################################
> > > ##########
> > > done
> > > Bytes transferred = 2047061 (1f3c55 hex)
> > > ## Booting kernel from Legacy Image at 89000000 ...
> > > 
> > >    Image Name:   Linux-2.6.35
> > >    Image Type:   SuperH Linux Kernel Image (gzip compressed)
> > >    Data Size:    2046997 Bytes =  2 MB
> > >    Load Address: 88001000
> > >    Entry Point:  88002000
> > >    Verifying Checksum ... OK
> > >    Uncompressing Kernel Image ... OK
> > > 
> > > Linux version 2.6.35 (user@ubuntu) (gcc version 4.4.1 (Sourcery G++
> > > Lite 4.4-200) ) #1 PREEMPT Wed Dec 15 14:38:22 GMT 2010
> > > Boot params:
> > > ... MOUNT_ROOT_RDONLY - 00000000
> > > ... RAMDISK_FLAGS     - 00000000
> > > ... ORIG_ROOT_DEV     - 00000000
> > > ... LOADER_TYPE       - 00000000
> > > ... INITRD_START      - 00000000
> > > ... INITRD_SIZE       - 00000000
> > > Memory limited to 248MB
> > > Booting machvec: R0P7724 (EcoVec)
> > > Node 0: start_pfn = 0x8000, low = 0x17800
> > > 
> > > Zone PFN ranges:
> > >   Normal   0x00008000 -> 0x00017800
> > > 
> > > Movable zone start PFN for each node
> > > early_node_map[1] active PFN ranges
> > > 
> > >     0: 0x00008000 -> 0x00017800
> > > 
> > > Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
> > 62992
> > 
> > > Kernel command line: console=ttySC0,115200 root=/dev/nfs
> > > nfsroot2.168.10.30:/tftpboot/rootfs ip2.168.10.31 mem$8M
> > > memchunk.vpu=8m memchunk.veu0=4m memchunk.beu0=4m memchunk.vpu=8m
> > > memchunk.veu0=4m memchunk.beu0=4m
> > > PID hash table entries: 1024 (order: 0, 4096 bytes)
> > > 
> > > 
> > > ... other bits...
> > 
> > --
> > Ing. Fabio Giovagnini
> > 
> > Aurion s.r.l.
> > P.I e C.F.
> > 00885711200
> > skype: aurion.giovagnini
> > Tel. +39.051.594.78.24
> > Fax. +39.051.082.14.49
> > Cell. +39.335.83.50.919
> > www.aurion-tech.com

-- 
Ing. Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
skype: aurion.giovagnini
Tel. +39.051.594.78.24
Fax. +39.051.082.14.49
Cell. +39.335.83.50.919
www.aurion-tech.com
