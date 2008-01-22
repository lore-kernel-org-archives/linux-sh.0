From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 22 Jan 2008 00:37:21 +0000
Subject: Re: debian etch sh3 and sh4
Message-Id: <20080122003721.GA26756@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <82C85C285793D5ebiharaml@si-linux.com>
In-Reply-To: <82C85C285793D5ebiharaml@si-linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jan 21, 2008 at 09:22:51PM +0900, Yutaro Ebihara wrote:
> please let me introduce my archives.
> this is debian etch sh3 and sh4
> http://www.si-linux.co.jp/pub/debian-sh/
> 
> base tar balls.
> http://www.si-linux.co.jp/pub/debian-sh/base/etch/
> 
> you can use following apt line in your sh-box.
> 
> landy2:~# cat /etc/apt/sources.list
> deb http://www.si-linux.co.jp/pub/debian-sh etch main contrib non-free
> deb-src http://ftp.debian.org/debian/       etch main contrib non-free
> 
These sorts of efforts seem to pop up almost every other year, and then
quickly fall in to disarray. The same can be said for the Fedora Core
ports. Is there a plan to have this work merged back in to Debian proper,
and to keep it updated?

Currently Gentoo is the only viable option for a reasonably maintained
port, and the only one supported upstream. Seeing Debian or Fedora Core
in the same state would be nice, but the porters need to get serious
about what their goals are. A one-shot build is obsolete before it hits
the mailing list.
