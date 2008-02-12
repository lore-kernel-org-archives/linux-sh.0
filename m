From: Ben Dooks <ben@fluff.org>
Date: Tue, 12 Feb 2008 11:51:36 +0000
Subject: Re: [PATCH] sm501: Add uart support
Message-Id: <20080212115136.GA26519@fluff.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20080208095742.2041.46016.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080208095742.2041.46016.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, ben@fluff.org, linux-sh@vger.kernel.org

On Fri, Feb 08, 2008 at 06:57:42PM +0900, Magnus Damm wrote:
> This patch extends the sm501 mfd with 8250 uart support. We're currently
> doing this in the board specific r2d-1 code already, but it would be nice to
> do move things into the mfd since it's more chip specific than board specific.

Looks fine, will add to my set of SM501 changes to keep track of things
ready for the next kernel release window.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
