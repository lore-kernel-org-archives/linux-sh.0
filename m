From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 15 Nov 2013 20:03:16 +0000
Subject: Re: [PATCH v2 3/3] ARM: shmobile: Koelsch: enable Ether in defconfig
Message-Id: <52868C1B.2080505@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201311150217.23563.sergei.shtylyov@cogentembedded.com>
 <201311150223.40632.sergei.shtylyov@cogentembedded.com>
 <20131115052919.GA16854@verge.net.au>
In-Reply-To: <20131115052919.GA16854@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 11/15/2013 08:29 AM, Simon Horman wrote:

>> Enable the Ether driver in 'koelsch_defconfig' along with DHCP autoconfiguration
>> and NFS root.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> Thanks.

> I think it is also appropriate to remove these too.
> To be hones their inclusion appears to have been an error on my part.
> And if nfsroot is being enabled it seems to be a good opportunity
> to get rid of them.

> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE="../../initramfs/out/rootfs.arm.cpio"
> CONFIG_INITRAMFS_COMPRESSION_GZIP=y

    Hm, where are you seeing these? Tag renesas-devel-v3.12-20131112 doesn't 
contain anything similar...

WBR, Sergei

