From: Mika Westerberg <mika.westerberg@linux.intel.com>
Date: Thu, 17 Dec 2015 13:00:17 +0000
Subject: Re: [PATCH] i2c: make i2c_parse_fw_timings() always visible
Message-Id: <20151217130017.GZ1762@lahna.fi.intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450355556-19875-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1450355556-19875-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Jim Davis <jim.epost@gmail.com>

On Thu, Dec 17, 2015 at 01:32:36PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> This function used to be DT only, so it lived inside a CONFIG_OF block.
> Now it uses device attributes and must be moved outside of it. No
> further code changes.
> 
> Reported-by: Jim Davis <jim.epost@gmail.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
