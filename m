From: Oleg Endo <oleg.endo@t-online.de>
Date: Thu, 31 May 2012 23:13:02 +0000
Subject: Re: Has anyone got gcc-4.7.0 to build an SH64 kernel without dying?
Message-Id: <1338505982.2146.28.camel@yam-132-YW-E178-FTW>
List-Id: <linux-sh.vger.kernel.org>
References: <10426.1338312184@redhat.com>
In-Reply-To: <10426.1338312184@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 2012-05-30 at 13:53 +0900, Kaz Kojima wrote:
> Oleg Endo <oleg.endo@t-online.de> wrote:
> > Hmm .. abs:SI ... I'm afraid that was me.  Sorry about that!
> > Somebody noticed the problem with abs:SI on SH64 a while ago, too.
> > However, I don't remember whether the fix made it into 4.7.0 or into the
> > 4.7.1 branch.  Could you try with the 4.7.1 branch?
> 
> There were 3 patches for sh64-elf gcc build failure on trunk:
> 
> http://gcc.gnu.org/ml/gcc-patches/2012-03/msg00208.html
> http://gcc.gnu.org/ml/gcc-patches/2012-03/msg00209.html
> http://gcc.gnu.org/ml/gcc-patches/2012-03/msg00210.html
> 
> which are generic for sh64 targets.  The 3rd one is for the abs:SI
> issue.  I thought that they are included in 4.7 but they aren't
> because they were applied just after branching 4.8 done unfortunately.
> I guess that these patches should be backported to 4.7.1 branch.

Done :)

Cheers,
Oleg

