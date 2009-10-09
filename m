From: Bill Traynor <wmat@naoi.ca>
Date: Fri, 09 Oct 2009 12:57:15 +0000
Subject: Re: Can't Pull or Clone the SH Repository
Message-Id: <e71f4bea0910090557o2c1fa83bwded0dd7cbf641ae4@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <6e6aa1a80910090545i78523b6dve67760086088acff@mail.gmail.com>
In-Reply-To: <6e6aa1a80910090545i78523b6dve67760086088acff@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Fri, Oct 9, 2009 at 08:45, Dale Larson <dlarson42@gmail.com> wrote:
> I can't seem to get full access to the:
>
> http://www.kernel.org/pub/scm/linux/kernel/git/lethal/sh-2.6.git
>
> repository.
>
> A clone yields:
> ----------
> dlarson@UbuntuDale:~/scm/git$ git clone
> http://www.kernel.org/pub/scm/linux/kernel/git/lethal/sh-2.6.git
> sh-2.6.git

You've got sh-2.6.git twice here.

> Initialized empty Git repository in /home/dlarson/scm/git/sh-2.6.git/.git/
> Cannot get remote repository information.
> Perhaps git-update-server-info needs to be run there?
> ----------
>
> A pull or fetch from an already existing clone yields:
> ----------
> dlarson@UbuntuDale:~/scm/git/linux-sh-2.6.git$ git branch
> * cachetlb
> =A0for-2.6.30
> =A0master
> dlarson@UbuntuDale:~/scm/git/linux-sh-2.6.git$ git pull
> error: Failed connect to www.kernel.org:80; Operation now in progress
> error: Failed connect to www.kernel.org:80; Operation now in progress
> You asked me to pull without telling me which branch you
> want to merge with, and 'branch.cachetlb.merge' in
> your configuration file does not tell me either. =A0Please
> name which branch you want to merge on the command line and
> try again (e.g. 'git pull <repository> <refspec>').

git-pull works fine for me as of 5 minutes ago:

git pull
remote: Counting objects: 43, done.
remote: Compressing objects: 100% (32/32), done.
remote: Total 32 (delta 26), reused 0 (delta 0)
Unpacking objects: 100% (32/32), done.
From git://git.kernel.org/pub/scm/linux/kernel/git/lethal/sh-2.6
   59c82d1..a2767cf  master     -> origin/master
   59c82d1..a2767cf  sh/for-2.6.32 -> origin/sh/for-2.6.32
Updating 59c82d1..a2767cf
Fast forward
 arch/sh/boards/mach-ecovec24/setup.c |    5 ++++
 arch/sh/mm/cache-sh4.c               |    2 +-
 arch/sh/mm/cache-sh7705.c            |    4 +-
 arch/sh/mm/ioremap_32.c              |    2 +-
 arch/sh/mm/pmb.c                     |   37 ++++++++++++++++++++++++++++--=
---
 5 files changed, 40 insertions(+), 10 deletions(-)

> See git-pull(1) for details on the refspec.
>
> If you often merge with the same branch, you may want to
> configure the following variables in your configuration
> file:
>
> =A0 =A0branch.cachetlb.remote =3D <nickname>
> =A0 =A0branch.cachetlb.merge =3D <remote-ref>
> =A0 =A0remote.<nickname>.url =3D <url>
> =A0 =A0remote.<nickname>.fetch =3D <refspec>
>
> See git-config(1) for details.
> dlarson@UbuntuDale:~/scm/git/linux-sh-2.6.git$ git fetch
> error: Failed connect to www.kernel.org:80; Operation now in progress
> error: Failed connect to www.kernel.org:80; Operation now in progress
> ----------
>
> I've been using the http protocol version rather than the git protocol
> because I have to work through an authenticated http proxy firewall.
>
> Anyone have an idea for fixing this?
>
> Dale Larson
> Johnson Controls, Inc
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
