From: Joe Perches <joe@perches.com>
Date: Sat, 29 Dec 2007 18:07:05 +0000
Subject: Re: [PATCH] SH/Dreamcast - add support for GD-Rom device
Message-Id: <1198951625.4861.25.camel@localhost>
List-Id: <linux-sh.vger.kernel.org>
References: <1198774339.6170.11.camel@localhost.localdomain>
	 <1198796281.4833.31.camel@localhost>  <1198801142.5354.67.camel@odie>
	 <1198893469.4861.9.camel@localhost>
	 <1198929826.6278.11.camel@localhost.localdomain>
In-Reply-To: <1198929826.6278.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>

On Sat, 2007-12-29 at 12:03 +0000, Adrian McMenamin wrote:
> This won't work see include/scsi/scsi.h
> /*
> *  SENSE KEYS
> */
> 
> #define NO_SENSE            0x00
> #define RECOVERED_ERROR     0x01
> #define NOT_READY           0x02
> #define MEDIUM_ERROR        0x03
> #define HARDWARE_ERROR      0x04
> #define ILLEGAL_REQUEST     0x05
> #define UNIT_ATTENTION      0x06
> #define DATA_PROTECT        0x07
> #define BLANK_CHECK         0x08
> #define COPY_ABORTED        0x0a
> #define ABORTED_COMMAND     0x0b
> #define VOLUME_OVERFLOW     0x0d
> #define MISCOMPARE          0x0e
> 
> (The GD device specs says it supports 0, 1, 2, 3,4, 5, 6, 7 and 0xB)
> 
> ie we could get a sense key of 0x0B which would be greater than the
> array size. I think you'd have to hard code the limit.

Then shouldn't this test be:

	for (i = 0; i < ARRAY_SIZE(sense_texts); i++) {
		if (sense_key = sense_texts[i].sense_key)
			printk(KERN_INFO "GDROM: %s\n", sense_texts[i].text);
	}
	if (i >= ARRAY_SIZE(sense_texts))
		printk(KERN_ERR "GDROM: Unknown sense key: %d\n", sense_key);

cheers, Joe

