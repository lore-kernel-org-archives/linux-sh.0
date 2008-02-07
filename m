From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Thu, 07 Feb 2008 20:28:34 +0000
Subject: Sorry but I do not understand.
Message-Id: <200802072128.34795.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

What exaclty means this following:
root:/home> cp nfs/sdl5thApp .
root:/home> ./sdl5thApp
Allocation of length 1072838 from process 48 failed
DMA per-cpu: empty
DMA32 per-cpu: empty
Normal per-cpu:
cpu 0 hot: high 0, batch 1 used:0
cpu 0 cold: high 0, batch 1 used:0
HighMem per-cpu: empty
Free pages:        9244kB (0kB HighMem)
Active:0 inactive:4 dirty:0 writeback:0 unstable:0 free:2311 slab:1073 
mapped:0 pagetables:0
DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB 
pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 16 16
DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB 
pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 16 16
Normal free:9244kB min:2560kB low:10368kB high:10496kB active:0kB 
inactive:16kB present:16384kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:640kB low:2560kB high:2560kB active:0kB inactive:0kB 
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: empty
DMA32: empty
Normal: 7*4kB 6*8kB 3*16kB 3*32kB 1*64kB 0*128kB 1*256kB 1*512kB 0*1024kB 
0*2048kB 2*4096kB = 9244kB
HighMem: empty
Unable to allocate RAM for process text/data, errno 12
root:/home>
 

Thanks if anyone can explain to me.

Regards

-- 
Fabio Giovagnini

Aurion s.r.l.
via degli orti 11,
40050 Funo di Argelato (BO)
P.I e C.F.
00885711200
Tel. +39.335.8350919
Fax +39.051.8659009

www.aurion-tech.com

account telefono VoIP skype (www.skype.com):
aurion.giovagnini
