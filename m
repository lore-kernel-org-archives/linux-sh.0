From: Cyril Chemparathy <cyril@ti.com>
Date: Wed, 12 Sep 2012 22:54:27 +0000
Subject: Re: [PATCH v2] /dev/mem: use phys_addr_t for physical addresses
Message-Id: <505112A3.7080703@ti.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1347473158-7219-1-git-send-email-cyril@ti.com>
 <20120912181503.GB12840@kroah.com>
In-Reply-To: <20120912181503.GB12840@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Greg,

On 9/12/2012 2:15 PM, Greg KH wrote:
> On Wed, Sep 12, 2012 at 02:05:58PM -0400, Cyril Chemparathy wrote:
>> This patch fixes the /dev/mem driver to use phys_addr_t for physical
>> addresses.  This is required on PAE systems, especially those that run
>> entirely out of >4G physical memory space.
>
> What is the symptom if this patch is not applied?  Does it need to be
> backported to older kernels?  If so, which ones?
>

As far as I can tell, this change only benefits platforms where lowmem=20
lies outside the 32-bit addressable range.  On the ARM based KeyStone=20
platform, all of our memory is located above the 4GB limit at=20
0x8:0000:0000.  On this platform, trying to read lowmem breaks as follows:

# dd if=3D/dev/mem of=3D/dev/null bs=3D4k count=3D1 skip=8388608
dd: /dev/mem: Bad address

Assuming that we are unique in this regard (i.e. lowmem outside 4GB), I=20
don't see any reason to backport this to earlier kernels.

--=20
Thanks
- Cyril
