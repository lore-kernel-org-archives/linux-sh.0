From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 22 Mar 2018 09:01:14 +0000
Subject: Re: Moving forward with gdb sh native support?
Message-Id: <273ffa0b-8785-abf5-f6d5-66880e8a0d1f@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20180322013659.GA8118@brightrain.aerifal.cx>
In-Reply-To: <20180322013659.GA8118@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 03/22/2018 10:36 AM, Rich Felker wrote:
> I've recently gotten a chance to get back into gdb support for the sh
> architecture, and have a series of related patches I'm going to be
> submitting upstream soon.

Cool \o/

> The ones that aren't specific to SH2/J2/nommu stuff are adding support
> for software single-step (the hardware single-step assumed in the current
> linux-sh-low does not seem to be supported, as least not by Linux, on the
> vast majority of real and emulated hardware) and some minor bugfix prerequisites
> for that.
> Currently my changes here only cover gdbserver since there's no
> upstream sh-native support in gdb.
> 
> In conjunction with this I began looking again at the old sh native
> patches, which Adrian Glaubitz has been maintaining for the Debian
> side here:
> 
> https://github.com/glaubitz/binutils-gdb/commits/linux-sh
> (...)
> I know lack of sh native support has been a longstanding issue and
> Adrian has been doing a likely-painful job of keeping the patches
> up-to-date for a long time now, so whatever we do I hope we can work
> out a solution that gets it upstream soon.

FWIW, Yutaka Niibe has managed to determine the original author of the
SH patchset and it turns out this was not Takashi Yoshii who wrote the
patch but Toshinobu Sugioka. Yutaka has contacted him and asked him
to sign the copyright assignment for GDB. So, with me and Toshinobu
having signed the copyright assignment, it should now be possible to
get my out-of-tree patch merged upstream to GDB.

Can anyone from GDB upstream comment on this? Is there anything else
we need?

CC'ed Yutaka so he can comment if necessary. I would love to have
native SH support finally merged upstream. I'm happy to make any
changes necessary.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
