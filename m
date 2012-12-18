From: Simon Horman <horms@verge.net.au>
Date: Tue, 18 Dec 2012 02:14:52 +0000
Subject: Re: [PATCH v3 24/81] ARM: shmobile: r8a7779: Register PFC platform device
Message-Id: <20121218021452.GF28065@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1355611915-25060-25-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1355611915-25060-25-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Dec 15, 2012 at 11:50:58PM +0100, Laurent Pinchart wrote:
> Add arch code to register the PFC platform device instead of calling the
> driver directly. Platform device registration in the sh-pfc driver will
> be removed.

Acked-by: Simon Horman <horms+renesas@verge.net.au>
