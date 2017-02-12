From: Jonathan Corbet <corbet@lwn.net>
Date: Sun, 12 Feb 2017 23:35:32 +0000
Subject: Re: [PATCH 0/1] Documentation: convert sh interfaces to RST
Message-Id: <20170212163532.0fcbe4b5@lwn.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1484863602-27393-1-git-send-email-steven@wedontsleep.org>
In-Reply-To: <1484863602-27393-1-git-send-email-steven@wedontsleep.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 20 Jan 2017 09:06:41 +1100
Steve Kowalik <steven@wedontsleep.org> wrote:

> The following patch converts the SuperH interfaces DocBook into RST,
> however, I've not added it to the toctree, since I'm not 100% clear
> where it best fits.

So I have to apologize, this fell through the cracks in the disaster that
is my inbox.

The conversion itself looks mostly OK.  There is, however, a copyright
assertion in the original template file that should really be preserved
in the new file as well; usually I put those in as comments at the top of
the RST file.

As for where it fits; it seems maybe we need a subbook for
architecture-specific stuff.  Documentation/arch or /arch-guide?

Thanks,

jon
