From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 09 Aug 2012 04:22:05 +0000
Subject: Re: [PATCH] sh: sh7269: Fix LCD pinmux
Message-Id: <20120809042205.GE1614@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1344323440-11451-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1344323440-11451-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Aug 07, 2012 at 08:10:40AM +0100, Phil Edworthy wrote:
> There are two ports that can output the LCD data, therefore
> they have to use separate pimux identifiers so we can select
> the one we want to use.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Applied, thanks.
