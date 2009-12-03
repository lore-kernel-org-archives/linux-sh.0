From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 03 Dec 2009 21:09:20 +0000
Subject: Re: [PATCH] sh: include empty zero page in zImage
Message-Id: <20091203210920.GD11047@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091203122619.9975.58412.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091203122619.9975.58412.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 03, 2009 at 09:22:04AM -0500, Magnus Damm wrote:
> Hi Stuart,
> 
> On Thu, Dec 3, 2009 at 8:48 AM, Stuart MENEFY <stuart.menefy@st.com> wrote:
> > If you do this won't you overwrite any parameters from the boot loader?
> 
> True, so we probably want to do this in a different way.
> 
> I don't want to break anything of course, but I'm not sure if u-boot
> supports passing parameters to zImages. It's not a u-boot centric
> world though.
> 
> I remember adding command line passing code to kexec-tools for either
> vmlinux or zImage, but I doubt that both image types are properly
> supported in kexec today.
> 
> Any ideas? How are things for ST? I need to fix up romImage somehow at
> least. Maybe zImage should be left alone as-is and work should be put
> into fixing the boot loaders.
> 
Yes, it is the boot loader that is broken, as it doesen't comply with the
boot ABI. We will not be applying any patches to the kernel to work
around boot loader laziness. The romImage case is a special one, similar
to XIP, and that's something that the current argument passing scheme
wasn't intended for. On the other hand, you can easily do what all of the
other boot loaders do and wrap the zImage while inserting the argument
page immediately following it.

I'm quite frankly amazed at the number of patches that have shown up to
work around this "problem" in multiple ways. It's called an ABI for a
reason folks, if you don't want to support it properly, don't be
surprised when things blow up.
