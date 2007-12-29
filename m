From: Joe Perches <joe@perches.com>
Date: Sat, 29 Dec 2007 01:57:49 +0000
Subject: Re: [PATCH] SH/Dreamcast - add support for GD-Rom device
Message-Id: <1198893469.4861.9.camel@localhost>
List-Id: <linux-sh.vger.kernel.org>
References: <1198774339.6170.11.camel@localhost.localdomain>
	 <1198796281.4833.31.camel@localhost>  <1198801142.5354.67.camel@odie>
In-Reply-To: <1198801142.5354.67.camel@odie>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Simon Holm =?ISO-8859-1?Q?Th=F8gersen?= <odie@cs.aau.dk>
Cc: Adrian McMenamin <adrian@newgolddream.dyndns.info>, Paul Mundt <lethal@linux-sh.org>, Jens Axboe <jens.axboe@oracle.com>, LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

On Fri, 2007-12-28 at 01:18 +0100, Simon Holm Th=C3=B8gersen wrote:
> > -	while ((ctrl_inb(GDROM_ALTSTATUS_REG) & 0x80) && (time_before(jiffies=
, timeout)))
> > +	while (gdrom_is_busy() && (time_before(jiffies, timeout)))
> You don't need those parentheses.
> > +		while (((ctrl_inb(GDROM_ALTSTATUS_REG) & 0x88) !=3D 8) &&
> > +		       (time_before(jiffies, timeout)))
> What about a nice telling function like gdrom_is_busy for this?

Perhaps (uncompiled/untested):

    Remove unnecessary parenthesis
    Remove GDROM: prefix from sense_texts
    Add function gdrom_data_request
    Check sense_key against sense_text array size

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/cdrom/gdrom.c |   53 ++++++++++++++++++++++++++-------------------=
---
 1 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 59d26e0..ab95438 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -80,16 +80,15 @@ static const struct {
 	int sense_key;
 	const char * const text;
 } sense_texts[] =3D {
-	{NO_SENSE, "GDROM: OK"},
-	{RECOVERED_ERROR, "GDROM: Recovered from error"},
-	{NOT_READY, "GDROM: Device not ready"},
-	{MEDIUM_ERROR, "GDROM: Disk not ready"},
-	{HARDWARE_ERROR, "GDROM: Hardware error"},
-	{ILLEGAL_REQUEST, "GDROM: Command has failed"},
-	{UNIT_ATTENTION, "GDROM: Device needs attention - "
-			 "disk may have been changed"},
-	{DATA_PROTECT, "GDROM: Data protection error"},
-	{ABORTED_COMMAND, "GDROM: Command aborted"},
+	{NO_SENSE, "OK"},
+	{RECOVERED_ERROR, "Recovered from error"},
+	{NOT_READY, "Device not ready"},
+	{MEDIUM_ERROR, "Disk not ready"},
+	{HARDWARE_ERROR, "Hardware error"},
+	{ILLEGAL_REQUEST, "Command has failed"},
+	{UNIT_ATTENTION, "Device needs attention - disk may have been changed"},
+	{DATA_PROTECT, "Data protection error"},
+	{ABORTED_COMMAND, "Command aborted"},
 };
=20
 static struct platform_device *pd;
@@ -140,11 +139,16 @@ static bool gdrom_is_busy(void)
 	return (ctrl_inb(GDROM_ALTSTATUS_REG) & 0x80) !=3D 0;
 }
=20
+static bool gdrom_data_request(void)
+{
+	return (ctrl_inb(GDROM_ALTSTATUS_REG) & 0x88) =3D 8;
+}
+
 static void gdrom_wait_clrbusy(void)
 {
 	/* long timeouts - typical for a CD Rom */
 	unsigned long timeout =3D jiffies + HZ * 60;
-	while (gdrom_is_busy() && (time_before(jiffies, timeout)))
+	while (gdrom_is_busy() && time_before(jiffies, timeout))
 		cpu_relax();
 }
=20
@@ -153,7 +157,7 @@ static void gdrom_wait_busy_sleeps(void)
 	unsigned long timeout;
 	/* Wait to get busy first */
 	timeout =3D jiffies + HZ * 60;
-	while (!gdrom_is_busy() && (time_before(jiffies, timeout)))
+	while (!gdrom_is_busy() && time_before(jiffies, timeout))
 		cpu_relax();
 	/* Now wait for busy to clear */
 	gdrom_wait_clrbusy();
@@ -186,8 +190,8 @@ static void gdrom_spicommand(void *spi_string, int bufl=
en)
 	/* Wait until we can go */
 	gdrom_wait_clrbusy();
 	ctrl_outb(GDROM_COM_PACKET, GDROM_STATUSCOMMAND_REG);
-	while ((ctrl_inb(GDROM_ALTSTATUS_REG) & 0x88) !=3D 8)
-		cpu_relax(); /* wait for DRQ to be set to 1 */
+	while (!gdrom_data_request())
+		cpu_relax();
 	outsw(PHYSADDR(GDROM_DATA_REG), cmd, 6);
 }
=20
@@ -354,7 +358,7 @@ static int gdrom_drivestatus(struct cdrom_device_info *=
cd_info, int ignore)
 static int gdrom_mediachanged(struct cdrom_device_info *cd_info, int ignor=
e)
 {
 	/* check the sense key */
-	return ((ctrl_inb(GDROM_ERROR_REG) & 0xF0) =3D 0x60);
+	return (ctrl_inb(GDROM_ERROR_REG) & 0xF0) =3D 0x60;
 }
=20
 /* reset the G1 bus */
@@ -412,11 +416,13 @@ static int gdrom_getsense(short *bufstring)
 		return -EIO;
 	}
 	sense_key =3D sense[1] & 0x0F;
-	printk(KERN_INFO "%s\n", sense_texts[sense_key].text);
+	if (sense_key < ARRAY_SIZE(sense_texts))
+		printk(KERN_INFO "GDROM: %s\n", sense_texts[sense_key].text);
+	else
+		printk(KERN_ERR "GDROM: Unknown sense key: %d\n", sense_key);
=20
-	if (bufstring)
+	if (bufstring)			/* return additional sense data */
 		memcpy(bufstring, &sense[4], 2);
-					/* return additional sense data */
=20
 	if (sense_key < 2)
 		return 0;
@@ -550,19 +556,18 @@ static void gdrom_readdisk_dma(struct work_struct *wo=
rk)
 		ctrl_outb(0, GDROM_INTSEC_REG);
 		/* In multiple DMA transfers need to wait */
 		timeout =3D jiffies + HZ / 2;
-		while (gdrom_is_busy() && (time_before(jiffies, timeout)))
+		while (gdrom_is_busy() && time_before(jiffies, timeout))
 			cpu_relax();
 		ctrl_outb(GDROM_COM_PACKET, GDROM_STATUSCOMMAND_REG);
 		timeout =3D jiffies + HZ / 2;
-		while (((ctrl_inb(GDROM_ALTSTATUS_REG) & 0x88) !=3D 8) &&
-		       (time_before(jiffies, timeout)))
-			cpu_relax(); /* wait for DRQ to be set to 1 */
+		while (!gdrom_data_request() && time_before(jiffies, timeout))
+			cpu_relax();
 		gd.pending =3D 1;
 		gd.transfer =3D 1;
 		outsw(PHYSADDR(GDROM_DATA_REG), &read_command->cmd, 6);
 		timeout =3D jiffies + HZ / 2;
-		while ((ctrl_inb(GDROM_DMA_STATUS_REG)) &&
-		       (time_before(jiffies, timeout)))
+		while (ctrl_inb(GDROM_DMA_STATUS_REG) &&
+		       time_before(jiffies, timeout))
 			cpu_relax();
 		ctrl_outb(1, GDROM_DMA_STATUS_REG);
 		/* 5 second error margin here seems more reasonable */


