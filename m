From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 10 Feb 2017 21:06:13 +0000
Subject: Re: RFC: Add native support for Linux SH
Message-Id: <171f95c6-3834-0575-ae17-4c7c511f2b15@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Forgot to CC some relevant people and lists.

On 02/10/2017 09:55 PM, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> I have picked up an old patch which was posted to this mailing list
> in 2011 [1] which adds native GDB support for Linux SuperH (SH).
> 
> Since this patch was never merged for various reasons, it gained
> dust and needed some work to be usable with current versions of
> GDB again.
> 
> I have taken the patch and forward-ported it to the current version
> of GDB from git master. I have tested it on my SH7785LCR SuperH
> hardware on Debian unstable and I was able to debug simple C
> programs. I have not thoroughly tested the functionality, however.
> 
> With this post, I would like to ask for some feedback on how to
> proceed with this patch. The original author of the patch is
> Takashi Yoshii who wrote it while working at Renesas Electronics
> in Japan.
> 
> Back in 2011, one of the major show-stoppers why the patch was
> not merged was apparently the missing FSF copyright assignment
> by the author [2]. However, since Yoshii-san was working for
> Renesas back then, I think the copyright assignment would have
> to be signed by them and not him personally. And since Renesas
> has already contributed various SuperH code to various FSF
> projects like gcc and binutils, I'd assume that the necessary
> FSF copyright assignment has already been signed.
> 
> I have also asked Yutaka Niibe (CC'ed) to try to get into touch
> with Takashi Yoshii through his old connections at Renesas, in
> case we would need some input from Yoshii-san's side.
> 
> As for the technical part: I'm happy to take any feedback and
> improve the patch so it has reached the necessary quality to
> be able to get merged into GDB mainline.
> 
> Having native GDB support for Linux SH has become relevant
> again since the SuperH architecture is currently being
> redeveloped as the J-Core open source architecture [3].
> 
> Thanks,
> Adrian
> 
>> [1] http://www.cygwin.com/ml/gdb-patches/2011-11/msg00490.html
>> [2] http://www.cygwin.com/ml/gdb-patches/2011-11/msg00499.html
>> [3] http://j-core.org/
> 
> --
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer - glaubitz@debian.org
> `. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
> 


-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
