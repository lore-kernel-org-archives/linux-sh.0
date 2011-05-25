From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 25 May 2011 02:44:49 +0000
Subject: Re: [PATCH 2/3] sh_mobile_meram: Safely disable MERAM operation when not initialized
Message-Id: <20110525024447.GG14329@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1306220482-29107-3-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1306220482-29107-3-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, May 24, 2011 at 04:01:21PM +0900, Damian Hobson-Garcia wrote:
> If the MERAM platform data is defined, but the MERAM has not been
> properly initaliazed we need to safely fall back to non-MERAM operation.
> 
> Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>

Applied, thanks. In the future please also Cc linux-fbdev, as ultimately
this all ends up going via the fbdev tree anyways.
