From: Daniel =?iso-8859-1?Q?Gl=F6ckner?= <daniel-gl@gmx.net>
Date: Thu, 17 Jun 2010 21:03:47 +0000
Subject: Re: [uClinux-dev] Userspace command line gcc options troubles
Message-Id: <20100617210346.GA422@minime.bse>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jun 17, 2010 at 12:32:56PM +0200, Fabio Giovagnini wrote:
> uclinux/bin/as: unrecognized option '--fdpic--isa=sh2a'

> How could I solve?

cd /home/fgiovagnini/sh7203/sh7203-uclinux-4.4-206/build/target/
./bin/sh-uclinux-gcc -dumpspecs > lib/gcc/sh-uclinux/4.4.1/specs
sed -i 's/subtarget_asm_spec)/& /' lib/gcc/sh-uclinux/4.4.1/specs

Best regards

  Daniel
