From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 11 Sep 2015 08:42:58 +0000
Subject: Re: [PATCH 1/2] i2c-tools: add new tool 'i2ctransfer'
Message-Id: <20150911104258.2563e238@endymion.delvare>
List-Id: <linux-sh.vger.kernel.org>
References: <1434710432-4182-1-git-send-email-wsa@the-dreams.de>
 <1434710432-4182-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1434710432-4182-2-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Wolfram,

On Fri, 19 Jun 2015 12:40:31 +0200, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> This tool allows to construct and concat multiple I2C messages into one
> single transfer. Its aim is to test I2C master controllers, and so there
> is no SMBus fallback.

Which is fine. That wouldn't make much sense anyway as not all I2C
transactions fit into the SMBus set. For SMBus transactions we already
have i2cdump, i2cget and i2cset.

> I've been missing such a tool a number of times now, so I finally got
> around to writing it myself. As with all I2C tools, it can be dangerous,
> but it can also be very useful when developing. I am not sure if distros
> should supply it, I'll leave that to Jean's experience. For embedded
> build systems, I think this should be selectable.

I think it can be included together with the other tools. It's just as
dangerous a tool as the other ones, not more. The fact that it can't be
used on SMBus-only controllers even kind of makes it less dangerous.

> Tested with various Renesas I2C IP cores as well as Tegra and AT91.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Not needed for i2c-tools contributions.

> ---
>  tools/Module.mk     |   8 +-
>  tools/i2ctransfer.c | 320 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>
>  2 files changed, 327 insertions(+), 1 deletion(-)
>  create mode 100644 tools/i2ctransfer.c

Where is the manual page? We need one, it's mandatory for some
distributions. And "make install" currently fails because
tools/i2ctransfer.8 is missing.

While this is not kernel code, I would recommend that you run the
kernel's scripts/checkpatch.pl on tools/i2ctransfer.c. Most of the
problems reported are relevant and fixing them would improve
readability.

Overall it looks really good. I made a lot of comments below but most
of them only express my preference and you are free to ignore them if
you disagree.

> diff --git a/tools/Module.mk b/tools/Module.mk
> index 641ac81..7192361 100644
> --- a/tools/Module.mk
> +++ b/tools/Module.mk
> @@ -18,7 +18,7 @@ else
>  TOOLS_LDFLAGS	+= -Llib -li2c
>  endif
>  
> -TOOLS_TARGETS	:= i2cdetect i2cdump i2cset i2cget
> +TOOLS_TARGETS	:= i2cdetect i2cdump i2cset i2cget i2ctransfer
>  
>  #
>  # Programs
> @@ -36,6 +36,9 @@ $(TOOLS_DIR)/i2cset: $(TOOLS_DIR)/i2cset.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)
>  $(TOOLS_DIR)/i2cget: $(TOOLS_DIR)/i2cget.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o
>  	$(CC) $(LDFLAGS) -o $@ $^ $(TOOLS_LDFLAGS)
>  
> +$(TOOLS_DIR)/i2ctransfer: $(TOOLS_DIR)/i2ctransfer.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o
> +	$(CC) $(LDFLAGS) -o $@ $^ $(TOOLS_LDFLAGS)
> +
>  #
>  # Objects
>  #
> @@ -52,6 +55,9 @@ $(TOOLS_DIR)/i2cset.o: $(TOOLS_DIR)/i2cset.c $(TOOLS_DIR)/i2cbusses.h $(TOOLS_DI
>  $(TOOLS_DIR)/i2cget.o: $(TOOLS_DIR)/i2cget.c $(TOOLS_DIR)/i2cbusses.h $(TOOLS_DIR)/util.h version.h $(INCLUDE_DIR)/i2c/smbus.h
>  	$(CC) $(CFLAGS) $(TOOLS_CFLAGS) -c $< -o $@
>  
> +$(TOOLS_DIR)/i2ctransfer.o: $(TOOLS_DIR)/i2ctransfer.c $(TOOLS_DIR)/i2cbusses.h $(TOOLS_DIR)/util.h version.h
> +	$(CC) $(CFLAGS) $(TOOLS_CFLAGS) -c $< -o $@
> +
>  $(TOOLS_DIR)/i2cbusses.o: $(TOOLS_DIR)/i2cbusses.c $(TOOLS_DIR)/i2cbusses.h
>  	$(CC) $(CFLAGS) $(TOOLS_CFLAGS) -c $< -o $@
>  
> diff --git a/tools/i2ctransfer.c b/tools/i2ctransfer.c
> new file mode 100644
> index 0000000..27f4d7a
> --- /dev/null
> +++ b/tools/i2ctransfer.c
> @@ -0,0 +1,320 @@
> +/*
> +    i2ctransfer.c - A user-space program to send concatenated i2c messages
> +    Copyright (C) 2015 Wolfram Sang <wsa@sang-engineering.com>
> +    Copyright (C) 2015 Renesas Electronics Corporation
> +
> +    Based on i2cget.c:
> +    Copyright (C) 2005-2012  Jean Delvare <jdelvare@suse.de>
> +
> +    which is based on i2cset.c:
> +    Copyright (C) 2001-2003  Frodo Looijaard <frodol@dds.nl>, and
> +                             Mark D. Studebaker <mdsxyz123@yahoo.com>
> +    Copyright (C) 2004-2005  Jean Delvare

I think you can skip this. If anyone really cares, it's already
mentioned in i2cget.c.

> +
> +    This program is free software; you can redistribute it and/or modify
> +    it under the terms of the GNU General Public License as published by
> +    the Free Software Foundation; either version 2 of the License, or
> +    (at your option) any later version.
> +
> +    This program is distributed in the hope that it will be useful,
> +    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +    GNU General Public License for more details.
> +*/
> +
> +#include <sys/ioctl.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <linux/i2c.h>
> +#include <linux/i2c-dev.h>
> +#include "i2cbusses.h"
> +#include "util.h"
> +#include "../version.h"
> +
> +enum parse_state {
> +	PARSE_GET_DESC,
> +	PARSE_GET_DATA

There should be a trailing comma, in case you ever need to add a state.

> +};
> +
> +#define PRINT_STDERR	(1 << 0)
> +#define PRINT_READ_BUF	(1 << 1)
> +#define PRINT_WRITE_BUF	(1 << 2)
> +#define PRINT_HEADER	(1 << 3)
> +
> +static void help(void)
> +{
> +	fprintf(stderr,
> +		"Usage: i2ctransfer [-f] [-y] [-v] [-V] I2CBUS DESC [DATA] [DESC [DATA]]...\n"
> +		"  I2CBUS is an integer or an I2C bus name\n"
> +		"  DESC describes the transfer in the form: {r|w}LENGTH[@address]\n"
> +		"    1) read/write-flag 2) LENGTH (range 0-65535) 3) I2C address (use last one if omitted)\n"

Note that the I2C_RDWR ioctl interface currently limits the per-message
length to 8192 bytes. I can't really think of a good reason for doing
so, other than the fact that buffers larger than this may be difficult
to allocate.

> +		"  DATA are LENGTH bytes for a write message. They can be shortened by a suffix:\n"
> +		"    = (keep value constant until LENGTH)\n"
> +		"    + (increase value by 1 until LENGTH)\n"
> +		"    - (decrease value by 1 until LENGTH)\n"
> +		"\nExample (bus 0, read 8 byte at offset 0x64 from eeprom at 0x50):\n"

The leading newline would rather go at end of previous line IMHO, or on
a line on its own to make it even clearer what the output will look
like.

> +		"  # i2ctransfer 0 w1@0x50 0x64 r8\n"
> +		"Example (same eeprom, at offset 0x42 write 0xff 0xfe .. 0x00 ):\n"

No space before the closing parenthesis. A shorter write would probably
serve better as an example, as it's unclear what will happen when the
register offset reaches 0x100.

> +		"  # i2ctransfer 0 w257@0x50 0x42 0xff-\n"
> +		);

The closing parenthesis can go at the end of the previous line, I think.

> +}
> +
> +static int check_funcs(int file)
> +{
> +	unsigned long funcs;
> +
> +	/* check adapter functionality */
> +	if (ioctl(file, I2C_FUNCS, &funcs) < 0) {
> +		fprintf(stderr, "Error: Could not get the adapter "
> +			"functionality matrix: %s\n", strerror(errno));
> +		return -1;
> +	}
> +
> +	if (!(funcs & I2C_FUNC_I2C)) {
> +		fprintf(stderr, MISSING_FUNC_FMT, "I2C transfers");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static void print_msgs(struct i2c_msg *msgs, __u32 nmsgs, unsigned flags)
> +{
> +	__u32 i, j;
> +	FILE *output = flags & PRINT_STDERR ? stderr : stdout;

Why don't you just pass the FILE * argument as the first parameter of
this function?

> +
> +	for (i = 0; i < nmsgs; i++) {
> +		int read = !!(msgs[i].flags & I2C_M_RD);
> +		int newline = !!(flags & PRINT_HEADER);

The double negation isn't needed.

> +
> +		if (flags & PRINT_HEADER)
> +			fprintf(output, "Msg %u: addr 0x%02x, %s, len %u",
> +				i, msgs[i].addr, read ? "read" : "write", msgs[i].len);
> +		if (msgs[i].len &&
> +		   (read = !!(flags & PRINT_READ_BUF) ||
> +		   !read = !!(flags & PRINT_WRITE_BUF))) {

Could be indented (aligned) better to improve readability. Also the
last two statements seems needlessly complex. I'd write:

		if (msgs[i].len &&
		    (read && (flags & PRINT_READ_BUF) ||
		     !read && (flags & PRINT_WRITE_BUF))) {

This approach would avoid all the double negations in this function.

> +			if (flags & PRINT_HEADER)
> +				fprintf(output, ", buf ");

You'd rather drop the trailing white space...

> +			for (j = 0; j < msgs[i].len; j++)
> +				fprintf(output, "0x%02x ", msgs[i].buf[j]);

... and move the white space at the beginning here. This avoids printing
a trailing space before the newline (which could cause an extra blank
line on display if you are unlucky with the terminal width.)

> +			newline = 1;
> +		}
> +		if (newline)
> +			fprintf(output, "\n");

In which case exactly would the newline not be printed? Read of length
0? I doubt it is worth caring about. I'd even say that printing a blank
line in this case is preferable, so that the output really corresponds
to what happened. Otherwise you can't tell the difference between read
of length 0 followed by read of length 1 and the other way around.

> +	}
> +}
> +
> +static int confirm(const char *filename, struct i2c_msg *msgs, __u32 nmsgs)
> +{
> +	fprintf(stderr, "WARNING! This program can confuse your I2C bus, cause data loss and worse!\n");
> +	fprintf(stderr, "I will send the following messages to device file %s:\n", filename);
> +	print_msgs(msgs, nmsgs, PRINT_STDERR | PRINT_HEADER | PRINT_WRITE_BUF);
> +
> +	fprintf(stderr, "Continue? [y/N] ");
> +	fflush(stderr);
> +	if (!user_ack(0)) {
> +		fprintf(stderr, "Aborting on user request.\n");
> +		return 0;
> +	}
> +
> +	return 1;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	char filename[20];
> +	char *end;
> +	int i2cbus, address = -1, file, arg_idx = 1, nmsgs = 0, nmsgs_sent;
> +	int force = 0, yes = 0, version = 0, verbose = 0;
> +	unsigned buf_idx = 0;
> +	unsigned long len, raw_data;
> +	__u8 data;
> +	__u8 *buf;
> +	__u16 flags;
> +	struct i2c_msg msgs[I2C_RDRW_IOCTL_MAX_MSGS];
> +	struct i2c_rdwr_ioctl_data rdwr;
> +	enum parse_state state = PARSE_GET_DESC;

That's a lot of local variables. I think some of them could be declared
inside the state machine. Did you try moving the state machine to a
separate function? Maybe if would improve readability.

> +
> +	/* handle (optional) arg_idx first */
> +	while (arg_idx < argc && argv[arg_idx][0] = '-') {
> +		switch (argv[arg_idx][1]) {
> +		case 'V': version = 1; break;
> +		case 'v': verbose = 1; break;
> +		case 'f': force = 1; break;
> +		case 'y': yes = 1; break;
> +		default:
> +			fprintf(stderr, "Error: Unsupported option "
> +				"\"%s\"!\n", argv[arg_idx]);
> +			help();
> +			exit(1);
> +		}
> +		arg_idx++;
> +	}
> +
> +	if (version) {
> +		fprintf(stderr, "i2ctransfer version %s\n", VERSION);
> +		exit(0);
> +	}
> +
> +	if (arg_idx = argc) {
> +		help();
> +		exit(0);

I think you want to return an error code here, not 0.

> +	}
> +
> +	i2cbus = lookup_i2c_bus(argv[arg_idx++]);
> +	if (i2cbus < 0)
> +		exit(1);
> +
> +	file = open_i2c_dev(i2cbus, filename, sizeof(filename), 0);
> +	if (file < 0 || check_funcs(file))
> +		exit(1);
> +
> +	while (arg_idx < argc) {
> +		char *arg_ptr = argv[arg_idx];
> +
> +		if (nmsgs > I2C_RDRW_IOCTL_MAX_MSGS) {
> +			fprintf(stderr, "Error: Too many messages (max: %d)\n",
> +				I2C_RDRW_IOCTL_MAX_MSGS);
> +			exit(1);
> +		}
> +
> +		switch (state) {
> +		case PARSE_GET_DESC:
> +			flags = 0;
> +
> +			switch (*arg_ptr++) {
> +			case 'r': flags |= I2C_M_RD; break;
> +			case 'w': break;
> +			default:
> +				fprintf(stderr, "Error: Invalid direction\n");
> +				goto err_out;
> +			}
> +
> +			len = strtoul(arg_ptr, &end, 0);
> +			if (len > 65535) {

0xffff would be easier to understand IMHO. Also you must check that
arg_ptr != end, i.e. you managed to parse anything. Otherwise a faulty
argument like w@0x50 will be parsed successfully (silently assuming len
= 0) and odds are that the following argument won't be parsed
successfully. In that case the error message will point the user to the
wrong argument.

> +				fprintf(stderr, "Error: Length invalid\n");
> +				goto err_out;
> +			}
> +
> +			arg_ptr = end;
> +			if (*arg_ptr) {
> +				if (*arg_ptr++ != '@') {
> +					fprintf(stderr, "Error: No '@' after length\n");

No @ after length is actually fine, that's what the "else" branch below
handles. The problem is no @ before address.

> +					goto err_out;
> +				}
> +
> +				/* We skip 10-bit support for now. If we want it, it
> +				 * should be marked with a 't' flag before the address
> +				 * here.
> +				 */
> +
> +				address = parse_i2c_address(arg_ptr);
> +				if (address < 0)
> +					goto err_out;
> +
> +				if (!force && set_slave_addr(file, address, 0))
> +					goto err_out;

It took me a while to realize that 1) this was not broken and 2) this
was actually useful. Please add a comment explaining that the only
purpose is to check that the slave address isn't busy. You don't
actually need to set the slave address at this point, the I2C_RDWR
ioctl doesn't make use of it.

> +
> +			} else {
> +				/* Reuse last address if possible */
> +				if (address < 0) {
> +					fprintf(stderr, "Error: No address given\n");
> +					goto err_out;
> +				}
> +			}
> +
> +			msgs[nmsgs].addr = address;
> +			msgs[nmsgs].flags = flags;
> +			msgs[nmsgs].len = len;
> +
> +			if (len) {
> +				buf = malloc(len);
> +				if (!buf) {
> +					fprintf(stderr, "Error: No memory for buffer\n");
> +					goto err_out;
> +				}
> +				memset(buf, 0, len);
> +				msgs[nmsgs].buf = buf;
> +			}

Else msgs[nmsgs].buf should be set to NULL. Otherwise you're passing a
random address value to the kernel.

> +
> +			if (flags & I2C_M_RD || len = 0) {
> +				nmsgs++;
> +			} else {
> +				buf_idx = 0;
> +				state = PARSE_GET_DATA;
> +			}
> +
> +			break;
> +
> +		case PARSE_GET_DATA:
> +			raw_data = strtoul(arg_ptr, &end, 0);
> +			if (raw_data > 255) {

0xff would be easier to understand IMHO. Here too you must check that
end != arg_ptr, otherwise '' or '+' will be parsed successfully
(assuming raw_data = 0.) 'x' would fail but with a confusing error
message ("Invalid data byte suffix".)

> +				fprintf(stderr, "Error: Data byte invalid\n");

"Invalid data byte" would sound better and be more consistent with
other error messages.

> +				goto err_out;
> +			}
> +			data = raw_data;
> +			len = msgs[nmsgs].len;
> +
> +			while (buf_idx < len) {
> +				msgs[nmsgs].buf[buf_idx++] = data;
> +
> +				if (!*end)
> +					break;
> +
> +				switch (*end) {
> +				case '+': data++; break;
> +				case '-': data--; break;
> +				case '=': break;
> +				default:
> +					fprintf(stderr, "Error: Invalid data byte suffix\n");
> +					goto err_out;
> +				}
> +			}
> +
> +			if (buf_idx = len) {
> +				nmsgs++;
> +				state = PARSE_GET_DESC;
> +			}
> +
> +			break;
> +
> +		default:
> +			fprintf(stderr, "Error: Unnkown state in state machine!\n");

Typo: Unknown

This can't actually happen, right? A comment saying so would be
appreciated. And "Internal error" instead of just "Error", so that the
user understands, if it ever happens.

> +			goto err_out;
> +		}
> +
> +		arg_idx++;
> +	}
> +
> +	if (state != PARSE_GET_DESC || nmsgs = 0) {

I'd be surprised if nmsgs = 0 can actually happen. You checked that at
least one parameter was left to parse on the command line before
entering the state machine. If you couldn't parse it then it must have
triggered some error earlier and you'll never reach this test.

> +		fprintf(stderr, "Error: Incomplete message\n");
> +		exit(1);
> +	}
> +
> +	if (!yes && !confirm(filename, msgs, nmsgs))
> +		exit(0);
> +
> +	rdwr.msgs = msgs;
> +	rdwr.nmsgs = nmsgs;
> +	nmsgs_sent = ioctl(file, I2C_RDWR, &rdwr);
> +	if (nmsgs_sent < 0) {
> +		fprintf(stderr, "Error: Sending messages failed: %s\n", strerror(errno));
> +		exit(errno);

I wouldn't recommend leaking errno back to the caller. Imagine errno is
EPERM (1), the user couldn't tell the difference with all other error
cases. IMHO there's no point in returning different error values unless
1) this is done consistently and 2) this is clearly documented in the
man page.

> +	} else if (nmsgs_sent < nmsgs) {
> +		fprintf(stderr, "Warning: only %d/%d messages were sent\n", nmsgs_sent, nmsgs);
> +	}
> +
> +	close(file);
> +
> +	print_msgs(msgs, nmsgs_sent, PRINT_READ_BUF | (verbose ? PRINT_HEADER | PRINT_WRITE_BUF : 0));
> +
> +	/* let Linux free malloced memory on termination */
> +	exit(0);
> +
> +err_out:
> +	fprintf(stderr, "Error: faulty argument is '%s'\n", argv[arg_idx]);
> +	exit(1);
> +}


-- 
Jean Delvare
SUSE L3 Support
