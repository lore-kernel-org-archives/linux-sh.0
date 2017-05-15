From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 15 May 2017 05:11:18 +0000
Subject: Re: QEMU serial still broken in -rc1.
Message-Id: <eeef85f2-7102-7e53-f93c-62c07dfe11a9@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <cdec4797-afe1-11f8-f926-fb5d356da625@landley.net>
In-Reply-To: <cdec4797-afe1-11f8-f926-fb5d356da625@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 05/15/2017 04:46 AM, Rob Landley wrote:
> As you can see from the fact the 2014 bug is still there in qemu, asking
> QEMU to fix anything is basically shouting into a hole. (Although if
> other people want to add their voices maybe it'll work better.)

Did you actually file a bug report in the QEMU tracker? I don't quite have
this experience with QEMU. They do fix bugs but they often take some time
to work through the patch queue because they usually get a larger number
of patches [1].

Adrian

> [1] https://patchwork.ozlabs.org/project/qemu-devel/list/

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
