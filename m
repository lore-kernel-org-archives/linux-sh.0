From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 31 May 2015 23:29:40 +0000
Subject: Re: [PATCH 0/4] i2c: small updates to the slave framework
Message-Id: <20150531232939.GA17187@katana>
List-Id: <linux-sh.vger.kernel.org>
References: <1431607205-2316-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1431607205-2316-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>

On Thu, May 14, 2015 at 02:40:01PM +0200, Wolfram Sang wrote:
> Before nailing down the DT representation problem, here are some smaller
> updates for the slave framework I have lying around.
> 
> Wolfram Sang (4):
>   i2c: add FUNC flag for slave capabilities
>   i2c: rcar: report slave capabilities to users
>   i2c: slave: docs: be more precise about the prerequsites
>   i2c: slave: add error messages to slave core
> 

Applied to for-next with one small update to patch 4.

