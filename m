From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 27 Apr 2012 00:31:08 +0000
Subject: Re: [PATCH] sh: switch various MSTP PM clocks to device-ID look-up
Message-Id: <20120427003107.GI22189@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1204262327080.32219@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1204262327080.32219@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 26, 2012 at 11:48:32PM +0200, Guennadi Liakhovetski wrote:
> Most SH drivers, accessing clocks, used for their devices, directly, have
> been converted to not use connection IDs for clock look-up. The runtime PM
> subsystem does the same. This means, that clock look-up entries for such
> devices with non-NULL connection IDs are useless. This patch converts such
> clock look-up entries to correct device IDs.
> 
This seems more like a failure in runtime PM than an issue with
connection IDs. We use connection IDs particularly in cases where there
is ambiguity, or multiple clocks for the same device, which we want to
toggle at different times. We won't be blindly moving off of connection
IDs where that behaviour is desirable if there is insufficiently granular
infratructure to migrate to.

Likewise having these sorts of arbitrary policy decisions offline is
completely pointless. If you wish to put forward a concrete proposal for
moving off of connection IDs, then send it to the list and let it stand
on its own merit.

> Another thing to note - I didn't convert TMU entries on sh7343 and sh7366. 
> On both these platforms currently there's one tmu clock look-up entry with 
> just a "tmu_fck" connection ID, but platforms themselves register multiple 
> tmu devices. Without datasheets I have no idea, whether some clock entries 
> are missing from the lookup table, or that entry controlls all TMU clocks, 
> or only one (#0?) TMU clock can be switched on and off.
> 
Most TMU clocks are grouped in pairs of 3 or 4, so one MSTP bit will
control channels 0 .. 3, etc.
