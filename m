From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 29 Mar 2010 03:15:23 +0000
Subject: Re: [PATCH 2.6.34-rc2] sh: Fix FDPIC binary loader
Message-Id: <20100329031522.GA8233@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4BAC849A.9090403@codesourcery.com>
In-Reply-To: <4BAC849A.9090403@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 26, 2010 at 09:55:38AM +0000, Andrew Stubbs wrote:
> Ensure that the aux table is properly initialized, even when optional 
> features are missing. Without this, the FDPIC loader did not work.
> 
> Signed-off-by: Andrew Stubbs <ams@codesourcery.com>

This was whitespace damaged and didn't apply, so I did it by hand. Please
double check your mailer settings for future patches, thanks.
