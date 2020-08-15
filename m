From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sat, 15 Aug 2020 10:40:58 +0000
Subject: Re: Ping: Pull Request for 5.9
Message-Id: <66205dc3-0193-9aad-b0c6-01d49655f8d3@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <b9ea23ec-4925-aee6-07a8-571971a42194@physik.fu-berlin.de>
In-Reply-To: <b9ea23ec-4925-aee6-07a8-571971a42194@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 8/15/20 4:17 AM, Rich Felker wrote:
>> Would it be possible to include Geert's fix for the IDE interface
>> of the LANDISK USL-5P devices [1]?
> 
> Yep, I'm preparing the pull request and was just about to ask if it
> should be included. Anything else not in next already that should be?

Great.

Let me check out your -next tree and see what we already have.

In any case, it should be Geert's patches to clean up printing
kernel messages, the 10 fixes by Christoph, Michael's patch for
SECCOMP, my patch and Matthew's patch to fix the unneeded constructor.

I'll compare your tree and linux-next if we're missing anything.

@Geert: What about that patch to fix the serial interface on LANDISK?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
