From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 21 Jun 2018 09:49:07 +0000
Subject: Re: RFC: Add native support for Linux SH
Message-Id: <c00b74d3-c80b-8da9-affc-fd33a62c6e09@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi everyone!

I was wondering whether there is a chance now for the Linux SH patches
to be upstreamed. All parties involved in the code have signed the
copyright assignment for the FSF.

Yutaka Niibe, one of the original initiators of the Linux SH port
has helped in the process in getting the missing copyright assignments,
see his mail here [1].

I have just rebased the patchset, it can be found in my github account [2].

I am currently not subscribed, so please keep me CC'ed.

Adrian

> [1] https://marc.info/?l=linux-sh&m2177366209159&w=2
> [2] https://github.com/glaubitz/binutils-gdb/tree/linux-sh

On 02/13/2017 11:27 PM, Yao Qi wrote:
> On Fri, Feb 10, 2017 at 8:55 PM, John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
>> With this post, I would like to ask for some feedback on how to
>> proceed with this patch. The original author of the patch is
>> Takashi Yoshii who wrote it while working at Renesas Electronics
>> in Japan.
>>
>> Back in 2011, one of the major show-stoppers why the patch was
>> not merged was apparently the missing FSF copyright assignment
>> by the author [2]. However, since Yoshii-san was working for
>> Renesas back then, I think the copyright assignment would have
>> to be signed by them and not him personally. And since Renesas
>> has already contributed various SuperH code to various FSF
>> projects like gcc and binutils, I'd assume that the necessary
>> FSF copyright assignment has already been signed.
>>
> 
> As far as I can see, the missing copyright assignment is still an issue.
> Renesas does contribute to various FSF projects, and they do have
> copy right assignments for these projects, like gcc, binutils and glibc.
> However, they don't have a copy right assignment for gdb for the author
> Yoshii-san.
> 

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
