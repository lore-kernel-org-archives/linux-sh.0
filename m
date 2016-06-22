From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 22 Jun 2016 21:02:15 +0000
Subject: Re: [PATCH] Make CONFIG_DEVTMPFS_MOUNT apply to initramfs/initmpfs.
Message-Id: <20160622210215.GA25333@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <576AE1C5.5090909@landley.net>
In-Reply-To: <576AE1C5.5090909@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, pavel@ucw.cz, akpm@linux-foundation.org, tglx@linutronix.de, mgorman@suse.de, mingo@kernel.org, keescook@chromium.org, paulmck@linux.vnet.ibm.com

On Wed, Jun 22, 2016 at 02:06:45PM -0500, Rob Landley wrote:
> From: Rob Landley <rob@landley.net>
> 
> Make CONFIG_DEVTMPFS_MOUNT apply to initramfs/initmpfs.
> 
> Update help text, slightly improve error reporting, move /dev/console open
> down after devtmpfs mount, don't check IS_ENABLED(CONFIG_TMPFS) before
> mounting devtmpfs (it's always there, even if just a ramfs alias), and
> report whether we think we're using tmpfs or ramfs for rootfs.

That's a lot of different things to be doing all at once in the same
patch.  Can you please break these out into individual logical changes?

thanks,

greg k-h
