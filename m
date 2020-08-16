From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 16 Aug 2020 17:02:38 +0000
Subject: Re: Ping: Pull Request for 5.9
Message-Id: <0f514caa-8203-f767-bde7-9e008468e69b@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <b9ea23ec-4925-aee6-07a8-571971a42194@physik.fu-berlin.de>
In-Reply-To: <b9ea23ec-4925-aee6-07a8-571971a42194@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 8/16/20 7:00 PM, Rich Felker wrote:
> Sounds good. I think most of it in principle isn't that bad to rebase,
> but I hit lots of breakage a couple years back when I tried making the
> PCI code work, and that was a show-stopper since it broke my emulated
> environment. Let's look at it again now.

Geert has got a LANDISK device working now that I sent to him (hence the
bug fixes he sent), so I'm confident we will be able to fix the remaining
issues with combined forces :-).

>> My hope is that with device tree support in the kernel for SH, it might be easier
>> to re-add support for the NextVoD devices of which I have plenty of.
> 
> In principle this is true, but there was a lot of out-of-tree stuff in
> STlinux that may be needed to support their SoC "platform devices". We
> need to find and archive git repos of that if possible, or otherwise
> at least the latest releases, to study and determine what's actually
> needed.

I have already started looking into this.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
