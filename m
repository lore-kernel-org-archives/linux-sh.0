From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 19 Mar 2010 08:37:52 +0000
Subject: Re: Is it possible usign QEMU for runnung kernel of sh2a?
Message-Id: <20100319083752.GE10003@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201003190627.44881.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003190627.44881.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 19, 2010 at 05:24:04PM +0900, Magnus Damm wrote:
> Hi Fabio,
> 
> On Fri, Mar 19, 2010 at 2:27 PM, Fabio Giovagnini
> <fabio.giovagnini@aurion-tech.com> wrote:
> > Hi, could you tell me please how to find info about using qemu for sh2a if it
> > is possible?
> 
> QEMU did not support sh2a last time I checked. And I doubt that anyone
> added it recently.
> 
Also note that sh2a is a very different architecture from sh4a, it would
take a rather radical redesign of the current backend to even begin to
support it, mixed instruction encodings aside.

If one wanted to experiment with uClinux under QEMU on SH the easier
option would simply be to provide an MMU-less SH-4 target and work with
that. When I first did the uClinux port in the 2.5 days it was to the
SH7091 with the MMU disabled, so the kernel can certainly handle it, even
though it likely needs a bit of updating to do it again on a contemporary
kernel.

> It may however be a good idea to use QEMU to learn about initramfs and
> user space programs on a different processor or architecture.
> 
> If I were you then I'd try to get QEMU working with x86 as target.
> When you have initramfs working on x86 in QEMU then you can easily
> move over to some other target.

MMU Linux and uClinux have enough differences that this becomes
impractical. QEMU does support microblaze and some others though which
would be a good starting point, there are also other emulation options
available for blackfin and ARM nommu parts that would at least help with
the userspace side of things.

If your intent is to work with the kernel or the sh2a hardware directly
then you'll still have to spend some time hacking up QEMU. This is
something I've wanted to do in QEMU for ages, but have simply never had
the time or resources for.
