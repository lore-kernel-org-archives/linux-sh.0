From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 03 Dec 2009 12:45:28 +0000
Subject: Re: Probably cache synchronization issue on SH7723
Message-Id: <aec7e5c30912030445m5a26a802tcc80047cf60bbfe9@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4B17B0D6.6020105@emtrion.de>
In-Reply-To: <4B17B0D6.6020105@emtrion.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Markus,

On Thu, Dec 3, 2009 at 9:36 PM, Markus Pietrek
<Markus.Pietrek@emtrion.de> wrote:
> when starting bigger graphical applications they suddenly stop with a
> segmentation fault or a bus error. If I execute the application a second
> time, everything is fine. Applications that are linked to shared libraries
> are more likely to fail than statically linked applications.
>
> Changing the cache from write-back to write-through fixes it. Maybe the
> instruction cache and the data cache are not synchronized correctly?
>
> I didn't have this problem with the linux-2.6.29 vanilla kernel. 2.6.32rc2
> from git://git.kernel.org/pub/scm/linux/kernel/git/lethal/sh-2.6 introduced
> it. And after a pull yesterday even /bin/init is failing.

I've found that sh7722 and sh7724 doesn't work with copy back cache
right now, see below. There may be other issues as well, but going
back to OK fixes it for my initramfs-only case.

Cheers,

/ magnus

BAD:

commit 39ac11c1607f1d566e7cf885acd403fa4f07f8a2
Author: Stuart Menefy <stuart.menefy@st.com>
Date:   Tue Oct 27 15:14:06 2009 +0000

   sh: Improve performance of SH4 versions of copy/clear_user_highpage

OK:

commit 49fb2cd2571e0134e5a12c5abab227696e4940c7
Merge: dfc3494 260af56
Author: Paul Mundt <lethal@linux-sh.org>
Date:   Tue Nov 24 16:32:11 2009 +0900

   Merge branch 'master' into sh/st-integration
