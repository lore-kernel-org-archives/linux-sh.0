From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Fri, 14 Mar 2014 19:01:22 +0000
Subject: Re: [PATCH] sh_eth: ensure pm_runtime cannot suspend the device during init
Message-Id: <53235202.9080409@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1394823605-31883-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1394823605-31883-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 14/03/14 19:00, Ben Dooks wrote:
> It seems the pm_rumtime work queue is causing the device to be suspended
> during initialisation, thus the initialisation may not be able to access
> registers properly. Use pm_runtime_get_sync() and pm_runtime_put_sync()
> to ensure that the pm system does not suspend it during the probe() call.

If this work's for Geert then I'll look into updating the header and
sending it to the netdev list.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
