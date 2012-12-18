From: Simon Horman <horms@verge.net.au>
Date: Tue, 18 Dec 2012 02:16:17 +0000
Subject: Re: [PATCH v3 26/81] ARM: shmobile: sh73a0: Register PFC platform device
Message-Id: <20121218021617.GI28065@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1355611915-25060-27-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1355611915-25060-27-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Dec 15, 2012 at 11:51:00PM +0100, Laurent Pinchart wrote:
> Add arch code to register the PFC platform device instead of calling the
> driver directly. Platform device registration in the sh-pfc driver will
> be removed.

Acked-by: Simon Horman <horms+renesas@verge.net.au>

