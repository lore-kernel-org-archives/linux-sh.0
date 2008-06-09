From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 09 Jun 2008 05:24:11 +0000
Subject: Re: Question on SH7763
Message-Id: <20080609052411.GA10260@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <29ab51dc0806050432i51cb4a38tcedca20496d61131@mail.gmail.com>
In-Reply-To: <29ab51dc0806050432i51cb4a38tcedca20496d61131@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jun 09, 2008 at 01:25:55PM +0900, Nobuhiro Iwamatsu wrote:
> >CC ed the u-boot mailinglist, because its more a u-boot topic. I used to
> >compile the u-boot
> >for a sh7750R based board (Sorry, patches for u-boot not posted yet ...)
> >with the
> >compiler from
> >
> >http://www.sh-linux.org
> >
> >There is also a fine readme.txt for installation.
> >
> >or use crosstools for making a compiler for your needs. See it at:
> >
> >http://www.kegel.com/crosstool/
> >
> >And then, hack the code ;-)
> >If your Flash supports CFI it should work with the CFI driver in u-boot.
> >Look in the u-boot readme how to start/modify the u-boot code.
> 
> And I wrote a document a little.
> Please check doc/README.sh
> 
On a somewhat related note, what is the status of the SH7203 patches? I
have some SH7206 and MX-G bits that build on top of them, yet I don't see
any of the SH7203 stuff in the git tree?
