From: Rich Felker <dalias@libc.org>
Date: Mon, 20 Apr 2020 17:11:49 +0000
Subject: Re: [PATCH 1/2] sh: remove sh5 support
Message-Id: <20200420171149.GB11469@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20200420123844.3998746-1-arnd@arndb.de>
In-Reply-To: <20200420123844.3998746-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org, ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk

On Mon, Apr 20, 2020 at 02:38:43PM +0200, Arnd Bergmann wrote:
> sh5 never became a product and has probably never really worked.
> 
> Remove it by recursively deleting all associated Kconfig options
> and all corresponding files.
> 
> For review purposes, this leaves out the files that can now be
> removed, in particular

Thank you! I haven't reviewed this yet, but if others do before I get
to it I'm happy to go with their opinions. I've been wanting to get
this removed for a long time because cleaning out stuff that's not
used/useful makes it easier to see what needs to be done for sh2/3/4
(rest of DT conversion, mmu support for j-core).

Rich
