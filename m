From: Rob Landley <rob@landley.net>
Date: Sat, 04 Apr 2020 00:28:27 +0000
Subject: Re: v5.6 is still throwing a stack trace on boot.
Message-Id: <2491f2c0-14f9-a4d0-17a0-25695e25671a@landley.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------68AFB16041F79F84DC60FB2B"
List-Id: <linux-sh.vger.kernel.org>
References: <24dbbbc2-644a-1f9e-4e82-b7b726a4ce42@landley.net>
In-Reply-To: <24dbbbc2-644a-1f9e-4e82-b7b726a4ce42@landley.net>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------68AFB16041F79F84DC60FB2B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 4/3/20 7:07 PM, Rich Felker wrote:
> On Fri, Apr 03, 2020 at 06:49:00PM -0500, Rob Landley wrote:
>> Run /init as init process
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 1 at mm/slub.c:2468 ___slab_alloc.constprop.0+0x1f0/0x290
>>
>> CPU: 0 PID: 1 Comm: swapper Not tainted 5.6.0 #2
>> PC is at ___slab_alloc.constprop.0+0x1f0/0x290
>> PR is at __slab_alloc.constprop.0+0x2e/0x54
>> PC  : 8c0a76c4 SP  : 8f829ea0 SR  : 400080f0
>> TEA : c0001240
>> R0  : 8c0a74d4 R1  : 00000100 R2  : 00000100 R3  : 00000000
>> R4  : 8f8020a0 R5  : 00000dc0 R6  : 8c01d678 R7  : 8fff5180
>> R8  : 8f8020a0 R9  : 8fff5180 R10 : 8c01d678 R11 : 80000000
>> R12 : 00007fff R13 : 00000dc0 R14 : 8f8020a0
>> MACH: 0000008b MACL: 0ae4849d GBR : 00000000 PR  : 8c0a7792
>>
>> Call trace:
>>  [<(ptrval)>] mm_alloc+0xe/0x48
>>  [<(ptrval)>] do_IRQ+0x0/0x50
>>  [<(ptrval)>] __slab_alloc.constprop.0+0x2e/0x54
>>  [<(ptrval)>] arch_local_irq_restore+0x0/0x24
>>  [<(ptrval)>] mm_init.isra.0+0xdc/0x138
>>  [<(ptrval)>] kmem_cache_alloc+0xd0/0x15c
>>  [<(ptrval)>] mm_init.isra.0+0xdc/0x138
>>  [<(ptrval)>] mm_init.isra.0+0xdc/0x138
>>  [<(ptrval)>] memset+0x0/0x8c
>>  [<(ptrval)>] __do_execve_file+0x22e/0x5d8
>>  [<(ptrval)>] kmem_cache_alloc+0x0/0x15c
>>  [<(ptrval)>] do_execve+0x16/0x24
>>  [<(ptrval)>] arch_local_irq_restore+0x0/0x24
>>  [<(ptrval)>] printk+0x0/0x24
>>  [<(ptrval)>] kernel_init+0x34/0xe8
>>  [<(ptrval)>] ret_from_kernel_thread+0xc/0x14
>>  [<(ptrval)>] schedule_tail+0x0/0x5c
>>  [<(ptrval)>] kernel_init+0x0/0xe8
>>
>> ---[ end trace 76213c1325250d90 ]---
> 
> Which hardware is this on? The qemu emulated board you're using?

Yes, qemu -M r2d. Built with attached miniconf, and run via:

qemu-system-sh4 -M r2d -serial null -serial mon:stdio -nographic -no-reboot \
  -m 256 -append "panic=1 HOST=sh4 console=ttySC1 noiotrap" -kernel zImage \
  -initrd sh4.cpio.gz

Rob

--------------68AFB16041F79F84DC60FB2B
Content-Type: text/plain; charset=UTF-8;
 name="sh4.miniconf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="sh4.miniconf"

IyBtYWtlIEFSQ0g9c2ggYWxsbm9jb25maWcgS0NPTkZJR19BTExDT05GSUc9c2g0Lm1pbmlj
b25mCiMgbWFrZSBBUkNIPXNoIC1qICQobnByb2MpCiMgYm9vdCBhcmNoL3NoL2Jvb3Qveklt
YWdlCgoKQ09ORklHX0NQVV9TVUJUWVBFX1NINzc1MVI9eQpDT05GSUdfTU1VPXkKQ09ORklH
X01FTU9SWV9TVEFSVD0weDBjMDAwMDAwCkNPTkZJR19WU1lTQ0FMTD15CkNPTkZJR19TSF9G
UFU9eQpDT05GSUdfU0hfUlRTNzc1MVIyRD15CkNPTkZJR19SVFM3NzUxUjJEX1BMVVM9eQpD
T05GSUdfU0VSSUFMX1NIX1NDST15CkNPTkZJR19TRVJJQUxfU0hfU0NJX0NPTlNPTEU9eQoK
Q09ORklHX1BDST15CkNPTkZJR19ORVRfVkVORE9SX1JFQUxURUs9eQpDT05GSUdfODEzOUNQ
PXkKCkNPTkZJR19QQ0k9eQpDT05GSUdfQkxLX0RFVl9TRD15CkNPTkZJR19BVEE9eQpDT05G
SUdfQVRBX1NGRj15CkNPTkZJR19BVEFfQk1ETUE9eQpDT05GSUdfUEFUQV9QTEFURk9STT15
CgojQ09ORklHX1NQST15CiNDT05GSUdfU1BJX1NIX1NDST15CiNDT05GSUdfTUZEX1NNNTAx
PXkKCiNDT05GSUdfUlRDX0NMQVNTPXkKI0NPTkZJR19SVENfRFJWX1I5NzAxPXkKI0NPTkZJ
R19SVENfRFJWX1NIPXkKI0NPTkZJR19SVENfSENUT1NZUz15CgoKIyBDT05GSUdfRU1CRURE
RUQgaXMgbm90IHNldApDT05GSUdfRUFSTFlfUFJJTlRLPXkKQ09ORklHX0JJTkZNVF9FTEY9
eQpDT05GSUdfQklORk1UX1NDUklQVD15CkNPTkZJR19OT19IWj15CkNPTkZJR19ISUdIX1JF
U19USU1FUlM9eQoKQ09ORklHX0JMS19ERVY9eQpDT05GSUdfQkxLX0RFVl9JTklUUkQ9eQpD
T05GSUdfUkRfR1pJUD15CgpDT05GSUdfQkxLX0RFVl9MT09QPXkKQ09ORklHX0VYVDRfRlM9
eQpDT05GSUdfRVhUNF9VU0VfRk9SX0VYVDI9eQpDT05GSUdfVkZBVF9GUz15CkNPTkZJR19G
QVRfREVGQVVMVF9VVEY4PXkKQ09ORklHX01JU0NfRklMRVNZU1RFTVM9eQpDT05GSUdfU1FV
QVNIRlM9eQpDT05GSUdfU1FVQVNIRlNfWEFUVFI9eQpDT05GSUdfU1FVQVNIRlNfWkxJQj15
CkNPTkZJR19ERVZUTVBGUz15CkNPTkZJR19ERVZUTVBGU19NT1VOVD15CkNPTkZJR19UTVBG
Uz15CkNPTkZJR19UTVBGU19QT1NJWF9BQ0w9eQoKQ09ORklHX05FVD15CkNPTkZJR19QQUNL
RVQ9eQpDT05GSUdfVU5JWD15CkNPTkZJR19JTkVUPXkKQ09ORklHX0lQVjY9eQpDT05GSUdf
TkVUREVWSUNFUz15CiNDT05GSUdfTkVUX0NPUkU9eQojQ09ORklHX05FVENPTlNPTEU9eQpD
T05GSUdfRVRIRVJORVQ9eQoK
--------------68AFB16041F79F84DC60FB2B--
