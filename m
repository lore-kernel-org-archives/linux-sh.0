From: Steve.Glendinning@smsc.com
Date: Tue, 28 Apr 2009 08:22:58 +0000
Subject: Re: [PATCH] sh: smsc911x support for the rsk7203 board
Message-Id: <OFB62D0D76.D8FF3D00-ON802575A6.002DEE44-802575A6.002E0A62@smsc.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090428080213.16323.31667.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090428080213.16323.31667.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Magnus Damm <magnus.damm@gmail.com> wrote on 28/04/2009 09:02:13:

> From: Magnus Damm <damm@igel.co.jp>
> 
> This patch adds support for the LAN9118 ethernet on rsk7203.
> 
> The LAN9118 controller is hooked up using a 16-bit data bus,
> but the rsk7203 board does not swap the byte lanes as needed
> between the sh7203 processor and the the ethernet controller.
> 
> In the processor the CS memory window is configured in 16-bit
> mode but the smsc911x driver is told to do 32-bit accesses to
> improve performance. The SMSC911X_SWAP_FIFO flag is used
> to tell the driver to do software byte swapping of fifo data.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---

Acked-by: Steve Glendinning <steve.glendinning@smsc.com>

